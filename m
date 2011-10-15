From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare
 3 on Windows
Date: Sat, 15 Oct 2011 12:27:30 +0200
Message-ID: <4E996012.8090002@gmail.com>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net> <1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net> <7vobxix0pk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 12:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF1T8-0005A5-OR
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 12:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1JOK1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 06:27:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:52565 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab1JOK1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 06:27:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RF1T3-00058e-QI
	for git@vger.kernel.org; Sat, 15 Oct 2011 12:27:49 +0200
Received: from p5ddb0837.dip0.t-ipconnect.de ([93.219.8.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 12:27:49 +0200
Received: from sschuberth by p5ddb0837.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 12:27:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0837.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <7vobxix0pk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183649>

On 15.10.2011 07:50, Junio C Hamano wrote:

> Hmm, does this only apply to Windows, or are there other platforms on
> which BC3 supplies bcomp for the exact same reason? What I am trying to

BC3 is only available for Linux and Windows, so it only applies to 
Windows currently.

-- 
Sebastian Schuberth
