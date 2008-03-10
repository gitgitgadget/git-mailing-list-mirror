From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: __git_find_subcommand function
Date: Mon, 10 Mar 2008 15:51:01 +0100
Message-ID: <20080310145101.GA6468@neumann>
References: <1204815512-18128-1-git-send-email-szeder@ira.uka.de> <20080308022342.GY8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjM7-0007fu-LG
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 15:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYCJOvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 10:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYCJOvE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 10:51:04 -0400
Received: from francis.fzi.de ([141.21.7.5]:42045 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751205AbYCJOvD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 10:51:03 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 15:51:00 +0100
Content-Disposition: inline
In-Reply-To: <20080308022342.GY8410@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-OriginalArrivalTime: 10 Mar 2008 14:51:00.0760 (UTC) FILETIME=[28101980:01C882BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76733>

On Fri, Mar 07, 2008 at 09:23:42PM -0500, Shawn O. Pearce wrote:
> Yup, you understood it correctly.  You found a cluster of "copy and
> paste programming" and I am happy to see it cleaned up.  Thanks.
Thanks.  I will send out the updated patches soon.

G=E1bor
