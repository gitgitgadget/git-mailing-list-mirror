From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 22:40:08 +0100
Message-ID: <200701302240.09212.jnareb@gmail.com>
References: <87odognuhl.wl%cworth@cworth.org> <20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net> <7vwt34xksz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 22:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC0h6-0001CZ-Fl
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 22:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXA3Viy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 16:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbXA3Viy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 16:38:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbXA3Vix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 16:38:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1658542uga
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 13:38:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BsjWSF6QmXSHf4j+CxYn3/kHPmeaB1T1077uWwlDey8cq4HibnxW5ZRBlgr/vGdJZdkFgvCuwrMePDzfLUP3mbRmEschzrPBW+eoIt3/2AkFcEK+Jm5jWkf/JHAn/yIQH00J+csWc0WhtB18GR+OD2AJtE8eSRscSVCGYyMPLxk=
Received: by 10.67.121.15 with SMTP id y15mr10720327ugm.1170193131754;
        Tue, 30 Jan 2007 13:38:51 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 39sm9235870ugb.2007.01.30.13.38.51;
        Tue, 30 Jan 2007 13:38:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt34xksz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38208>

Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
>> On Tue, Jan 30, 2007 at 10:02:40PM +0100, Jakub Narebski wrote:
>>>> I propose this warning be removed here. Otherwise, I either add text
>>>> to my instructions telling the user to ignore the warning message they
>>>> get, or else I go back to "-b build" and back to all the old problems
>>>> it causes.
>>> 
>>> I rather leave warning, but (perhaps around 1.5.1) remove the
>>> instructions. RTFM (err... I'm not sure we have one about detached HEAD).
>>
>> Or provide a "-q" flag to silence the warning ?
> 
> Or maybe make "-f" to mean "I know what I am doing, do not
> warn".

Unfortunately "-f" in git-checkout mean "force a re-read of everything."
Besides I'd like to have "-q" option for example for git-cat-file for
gitweb...

> P.S. Jakub, *please* do not break the thread.

I'll try.
-- 
Jakub Narebski
Poland
