From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Thu, 24 Feb 2011 10:11:00 +0100
Message-ID: <AANLkTinpvBr6aY__-tPfuEiHzFbeoTOxkMP-UGW3DGU8@mail.gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
 <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com>
 <4D63C095.8020206@gmail.com> <AANLkTinQwbTva+LxKo_4Sz=bN-iZ8Qu8MP-zWianz-iQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: xiaozhu <xiaozhu@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 10:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsXI3-0002f9-Q8
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 10:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab1BXJPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 04:15:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40823 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab1BXJPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 04:15:08 -0500
Received: by fxm17 with SMTP id 17so330970fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 01:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=td9vjE+pPlQ03egxTQwhXoBvxutUE2eYpsqs0J+4PdU=;
        b=GyCQl2rIO7U/R06nbuv4Po3T51wyDhnT5TBxICvtTNqW34oQsoucXlKeOmFY2yI1NX
         kvwHEeseZKhBh3kM1UdX6M/ysJ6k9vTOL2p7glLkGKGwgMTHidqDjgcezm1gXIVCkaRs
         uB5SpWWwU/I2FpnnicXZkmGiG1e8C/3UWt87M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bA9VP1QRPVEj67t1Z21sVmUu3C9eRbk2v5JUNLZKNJUJD+FjCJy63jHX8PFKmsaPoz
         Ngw7Tvyg5W5MSwY5Sk82gUetXU2s1Sby9gSGG1NVYIBNdoRwbq0YJMuXvLfEivU+r4T1
         aNqBtc+WSr8CmB/fM1y803EpHP8ssGnnEhw8I=
Received: by 10.223.101.134 with SMTP id c6mr706896fao.12.1298538681179; Thu,
 24 Feb 2011 01:11:21 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Thu, 24 Feb 2011 01:11:00 -0800 (PST)
In-Reply-To: <AANLkTinQwbTva+LxKo_4Sz=bN-iZ8Qu8MP-zWianz-iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167785>

On Thu, Feb 24, 2011 at 1:04 AM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Tue, Feb 22, 2011 at 14:56, xiaozhu <xiaozhu@gmail.com> wrote:
>> On 2011/02/22 1:23, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>> Did you read Documentation/SubmittingPatches?
>>
>> Where is the Documentation/SubmittingPatches? I didn't see anything
>> about submitting a patch on the site of git, and I also tried to fin=
d
>> something about it on git wiki, but I got nothing.
>
> I've added a link on the wiki [0] to the kernel.org 'cat blob' view.
>
> [0] https://git.wiki.kernel.org/index.php/Main_Page#Starting_points
>

Did you really? I can't find it, neither on the linked page nor a
matching entry on the recent changes page:
https://git.wiki.kernel.org/index.php/Special:RecentChanges
