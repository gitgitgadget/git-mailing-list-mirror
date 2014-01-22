From: Johan Herland <johan@herland.net>
Subject: Re: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 13:06:09 +0100
Message-ID: <CALKQrgdvgxAW50-YdKTd-fo7r6S5Hf8jA4Eh1VtzFhvytOzqYg@mail.gmail.com>
References: <52DFA9EF.4080309@alum.mit.edu>
	<CACsJy8AEU2dQPNknazRxEh12MNd=3Kw3+_tc3meS_Bs961ERkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 13:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5wZZ-0003BI-6p
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 13:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbaAVMGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 07:06:17 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:33808 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbaAVMGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 07:06:16 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1W5wZR-0008Hi-Si
	for git@vger.kernel.org; Wed, 22 Jan 2014 13:06:13 +0100
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1W5wZR-000EIw-EM
	for git@vger.kernel.org; Wed, 22 Jan 2014 13:06:13 +0100
Received: by mail-pa0-f42.google.com with SMTP id kl14so300343pab.15
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 04:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hUqsmjJy8bI4/QPCnI4nRHwcQ2zObhRM6IZp1EMrdzk=;
        b=MRUGD4ve9Wgk68xsAvScXJM7eafZeugGdPwQSMGZHpWPnP7/Zq6GZF07AHolBEZ188
         Uhf+e6MyGLhFvG6aukmJb36zZi0FGLzi44wvMinSyoG3Sag8kGmd4jljXOy+HIm5FG9i
         FVPiLYW7OWoGqo8G7V3FwSHP3tiuq0rNp+H43yeVZbWEHS/qZmezCae38W8MQMbqojPU
         XJOuvDzWNy+aPwUQZexOhSa25iMwF0AYaAs6RIVJ8AGbnFNPXe8JmcMgwtBLGEWCTyID
         sjs9pmzyys3gS/TO/n9DJ8GHSwz6jXQcWwuP6X65OAoJdT1vaFfBLjzyvZInDmHnD2Qk
         da+A==
X-Received: by 10.68.108.130 with SMTP id hk2mr1319032pbb.16.1390392369703;
 Wed, 22 Jan 2014 04:06:09 -0800 (PST)
Received: by 10.70.25.131 with HTTP; Wed, 22 Jan 2014 04:06:09 -0800 (PST)
In-Reply-To: <CACsJy8AEU2dQPNknazRxEh12MNd=3Kw3+_tc3meS_Bs961ERkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240823>

On Wed, Jan 22, 2014 at 12:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 22, 2014 at 6:22 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> These sections are inconsistent with the other manpages and seem
>> superfluous in a project that has, on the one hand, a public history
>> and, on the other hand, hundreds of contributors.  Would the mentioned
>> authors (CCed) consent to the removal of these sections?
>
> No problem from me.

No problems here.


-- 
Johan Herland, <johan@herland.net>
www.herland.net
