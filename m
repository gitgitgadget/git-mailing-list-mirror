From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: Merge git repositories
Date: Thu, 21 Feb 2008 14:34:36 +0100
Message-ID: <47BD7DEC.7040708@brefemail.com>
References: <20080220175901.71e7acc2@pc09.procura.nl>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 14:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSBdM-0000T8-Hl
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 14:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbYBUNhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 08:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYBUNhx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 08:37:53 -0500
Received: from main.gmane.org ([80.91.229.2]:37598 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYBUNhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 08:37:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JSBcR-00019c-W0
	for git@vger.kernel.org; Thu, 21 Feb 2008 13:37:48 +0000
Received: from ngw.virtuallogix.com ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 13:37:47 +0000
Received: from t2a2e9z8ncbs9qg by ngw.virtuallogix.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 13:37:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ngw.virtuallogix.com
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
In-Reply-To: <20080220175901.71e7acc2@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74615>

Hello,

On 02/20/2008 05:59 PM, H.Merijn Brand wrote:
> I have a whole bunch of git repositories that are conversions from SC=
CS.
> SCCS is a VCS that only deals with a single directory, and cannot cop=
e
> with directory hierarchies.
[SNIP]

> is it possible to merge git repos from sub-folders into the current r=
epo?

Doesn't maybe the subtree merge strategy help ?
See=20
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtr=
ee.html

My 2 cents
J=E9r=F4me
