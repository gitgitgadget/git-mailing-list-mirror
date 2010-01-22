From: Bill Lear <rael@zopyra.com>
Subject: Re: From git repository to server
Date: Fri, 22 Jan 2010 13:01:33 -0600
Message-ID: <19289.62989.96447.216230@blake.zopyra.com>
References: <201001221837.21862.gayleard@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timothy Murphy <gayleard@eircom.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:01:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYOlM-0003GL-5T
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 20:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab0AVTBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 14:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756161Ab0AVTBg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 14:01:36 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:46564
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756149Ab0AVTBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 14:01:35 -0500
Received: (qmail 20914 invoked by uid 500); 22 Jan 2010 19:01:34 -0000
In-Reply-To: <201001221837.21862.gayleard@eircom.net>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137774>

On Friday, January 22, 2010 at 18:37:21 (+0000) Timothy Murphy writes:
>I want to set up a GIT repository for a project on machine A ("alfred"),
>but I'd like it to be accessible on my web-server B ("helen").
>What is the simplest way to set this up?

You might try gitolite.  Easy to set up, administer, and provides
ssl-based security.w


Bill
