From: Jon Smirl <jonsmirl@gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_=5BPATCH=5D_=2Emailmap=3A_Entries_for_Alex_Benn=E9e=2C_Desk?=
	=?ISO-8859-1?Q?in_Miller=2C_Vitaly_=22=5FVi=22_Shukela?=
Date: Sun, 21 Mar 2010 15:51:55 -0400
Message-ID: <9e4733911003211251q24b6d799j92729ee29102351a@mail.gmail.com>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 21 20:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRBp-0006jO-QT
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 20:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0CUTv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 15:51:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:3990 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0CUTv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 15:51:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1001998qwh.37
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hbZ+VNLzLEfBB5DQyXZCV1mleVWHxPoWkbdVJBANetM=;
        b=dxAxkSktHzgnKwafDRm81w1Ae0aPgj0Le7uDO3yurgqrzJQqihlc42xL14tq1iQckT
         eV0vK+TRGbRzL7p2cDUjdwm0+FDhLHnVI39cXD6dGhuf2oAO+TJgRIPL414GXRQwmUNb
         HJmnpioCTE4rFF+6a5UneHBhfxKsSMVhYF9gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gQSBBzCpcr1TYvLKrttSb1dJD0AFKdetmxSgyQIG4HRiuB6xYf1kafWxs795LsGbbk
         GauyG2WImLZ52i31s//QfASJfqNS+bj4o+ZKpQ2EtTogrPwh9aRQnOvWsvA8jSiQX4QP
         lL7iJ83F5MZb3sIUDcOLo+QtuTiptQOYdrDAw=
Received: by 10.229.193.18 with SMTP id ds18mr2832119qcb.79.1269201115955; 
	Sun, 21 Mar 2010 12:51:55 -0700 (PDT)
In-Reply-To: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142854>

On Fri, Mar 19, 2010 at 7:02 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> With the current .mailmap, git shortlog shows the following for these=
:
>
> =A0 =A011 =A0Deskin Miller
> =A0 =A0 3 =A0Vitaly \"_Vi\" Shukela
> =A0 =A0 1 =A0Alex Bennee
> =A0 =A0 1 =A0Alex Benn=E9e
> =A0 =A0 1 =A0Deskin Miler
> =A0 =A0 1 =A0Vitaly _Vi Shukela

Which tool is introducing the charset errors?

Is there an easy way to add a check indicating a new name/email pair
and asking if it is correct?

--=20
Jon Smirl
jonsmirl@gmail.com
