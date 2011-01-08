From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: bug in gitk: history moves right when scrolling up and down with
 mouse wheel
Date: Fri, 07 Jan 2011 18:17:37 -0600
Message-ID: <4D27AD21.9060205@gmail.com>
References: <4D275F02.1030100@gmail.com> <1juqtpt.1dxkc9x1ho9gxzM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sat Jan 08 01:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbMVl-0001VR-Eq
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1AHASS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:18:18 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50206 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1AHASR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 19:18:17 -0500
Received: by gwj20 with SMTP id 20so7952529gwj.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=s6KerQqfO/TcuvFhJ4wrmTvQ57Dn/+wO+1kENSCZ8Cc=;
        b=LMWZp7IlZWYTvn8Z55j68zfi164e+9VRN7HPTZU2zMHTnzRdAl8nDnab/XlzIbx5Oh
         3geBhCFThpGfDUxXuP6JEziHYKjDsjoM9Z47UIm6cC61MLabft5WJ6q3GWoVDE//NCqN
         qPBoKUgFs9Ijq2r6O6Z66VIuZ0W3XdcWpN5BE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=kRjP8ANqLDbnjccXimkJIBEVTnt4ETjrkjM8xnHV38nHES18RB4Sn1vBpwYSGtEyxx
         moMxHnPEOL/d2KUhV7jU5Aibgwf/adLFpoPhgldGI/6/RvlBa9vdk/+nB4EzhmtNPuE8
         8Jr8uhky6N/Hb69T4rvIbIOpO2jHJ2/k7Q+Tc=
Received: by 10.90.114.5 with SMTP id m5mr3935698agc.25.1294445896421;
        Fri, 07 Jan 2011 16:18:16 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c34sm34164511anc.30.2011.01.07.16.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 16:18:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1juqtpt.1dxkc9x1ho9gxzM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164793>

On 1/7/2011 2:24 PM, Stefan Haller wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  wrote:
>
>> Actually, I've wanted the ability to scroll left and right in the
>> history pane for quite a while.  Resorting to shrinking the fontsize and
>> the other columns only goes so far when trying to see a list of
>> equivalent refs.  If the ability to scroll left and right can be kept
>> that would be cool.
>
> Interesting.  On the Mac it *is* possible to scroll left and right, and
> it absolutely drives me nuts, so I disabled it in my private build.
> I guess it's ok with a mouse, where shift-wheel scrolls horizontally,
> but on a track-pad with two-finger scrolling, where you can scroll both
> horizontally and vertically with a single guesture, it is completely
> undesirable.
>
I agree.  What would be ideal is a left-right scroll bar like the 
up-down scrollbar.

v/r,
Neal
