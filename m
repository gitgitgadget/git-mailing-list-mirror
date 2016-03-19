From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 2/2] gitk: add an option to enable sorting the "Tags
 and heads" view by ref type
Date: Sat, 19 Mar 2016 17:55:28 +1100
Message-ID: <20160319065528.GD27126@fergus.ozlabs.ibm.com>
References: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
 <1458327097-92126-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahAsa-00048z-1t
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 08:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbcCSHAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 03:00:47 -0400
Received: from ozlabs.org ([103.22.144.67]:59479 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbcCSHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 03:00:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3qRtK12x1sz9s9Y; Sat, 19 Mar 2016 18:00:37 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1458327097-92126-3-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289290>

On Fri, Mar 18, 2016 at 02:51:37PM -0400, Michael Rappazzo wrote:
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>

This looks to me like the kind of thing that could have a checkbox in
the Preferences window and get saved on disk along with other
preferences, rather than only being available via a command-line
option.

Paul.
