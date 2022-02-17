import {generateReportFromData} from '../../helpers.js';

export async function report(execute, metadata) {
  const {cronPattern, name, title} = metadata;
  return {
    cronPattern,
    name,
    execute: async () => {
      const startTime = new Date();
      console.log(
          `[INFO] Starting with reports for [${title}] @ ${startTime.toISOString()}`);
      await execute();
      console.log(
          `[INFO] Finished reports for [${title}] @ ${new Date().toISOString()}. ` +
          `Time elapsed: ${Math.abs(new Date() - startTime)}ms`,
      );
    },
  };
}
/**
 * Generates a CSV for the given sparql query-result
 *
 * @param result - the query-result
 * @param metadata - metadata for the CSV file
 * @returns {Promise<void>}
 */
export async function generateReportFromQueryResult({results, head}, metadata) {
  if (!(results && results.bindings.length)) {
    console.warn('[WARN] nothing to report on ...');
  } else {
    const bindings = results.bindings;
    const vars = head.vars;
    const data = bindings.map(row => {
      const obj = {};
      vars.forEach((variable) => {
        obj[variable] = getSafeValue(row, variable);
      });
      return obj;
    });
    await generateReportFromData(data, vars, metadata);
  }
}

/**
 * Translate a query-result row variable to a CSV safe value
 *
 * Some values might contain comas, wrapping them in escapes quotes doesn't disturb the columns
 *
 * @param row
 * @param variable
 * @returns {string|null}
 */
export function getSafeValue(row, variable) {
  return row[variable] ? `\"${row[variable].value}\"` : null;
}