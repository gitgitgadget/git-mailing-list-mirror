From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 10:37:16 +0200
Message-ID: <46d6db660907300137m32c1f49dx5b177720dc475d69@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
	 <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
	 <alpine.DEB.1.00.0907300018451.8306@pacific.mpi-cbg.de>
	 <46d6db660907291550q62d4383au7e847d535058558d@mail.gmail.com>
	 <alpine.DEB.1.00.0907300159250.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 10:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWRBH-0002u4-9X
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZG3Ij6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZG3Ij6
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:39:58 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:55229 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbZG3Ij5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 04:39:57 -0400
Received: by fxm28 with SMTP id 28so480444fxm.17
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0nCazTSqZhQ6l4Z7uYus7nVcbDhzetHP0HkmcxgiuDU=;
        b=ORGBOXnW47LLN+eepgoM9Njqg3oP6rafUMExnSBYNRXLZGuopCqV6TQRrHgVi7YmNX
         rb2+qSNT5mWYoqxLZ5KHrEoyQ1a35q47EblObinR33kSG3EpeGP5g5IoH174iVkCkNpn
         fKAE/ulQf2ghOs1ogK3V2dvUCkrLn7PQXlD6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u6OXfn6V5jiPAFH73U+aT+SZzmQG4Euni6DmedvUt35P0CZjni8yntRtXpk3ojwo1U
         Qlw+hSQ7tAMhCiOHcdBNgBM/2kSL3Yw9jPBhw9HBZttHIFcN+EcfWdrCq8IiePy2RzcP
         LzTdkj0gkTimsH56yBfSMATDp+udU6RgEVgE4=
Received: by 10.204.58.208 with SMTP id i16mr895709bkh.63.1248943036178; Thu, 
	30 Jul 2009 01:37:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907300159250.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124454>

On Thu, Jul 30, 2009 at 2:21 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 30 Jul 2009, Christian MICHON wrote:
>
>> On Thu, Jul 30, 2009 at 12:20 AM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>
>> > I will not guess, especially since I am dead tired after that hour=
 it
>> > always takes to make a new release.
>>
>> I believe we're both on CET :)
>
> I guess I am really too tired, as I thought that I had tested, but
> obviously only tested the https-and-send-email installer.
>
> But in the meantime, I found the issue, fixed and re-uploaded it. =A0=
=46WIW
> the portable application was not affected, and funnily enough, the ne=
t
> installer works (although I wonder why).

http://msysgit.googlecode.com/files/Git-1.6.4-preview20090730.exe
works on Vista and winXP. I will test on win2003 later, but I guess it
should be ok.

>
> Thanks for your report and help in diagnosing the problem.
>

no pb

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
