From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 13:35:27 +0200
Message-ID: <AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 13:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjW4N-0007ZZ-60
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 13:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890Ab0HLLf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 07:35:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47015 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab0HLLf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 07:35:28 -0400
Received: by qwh6 with SMTP id 6so1396376qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=dhEKp8lnT1/q+E5I/ZGGhOyYJIO3n8eV6NbbRImsBXc=;
        b=KYAEY+I+pI9FN5uT2o67ePvtjaScBbOBSfhnZFZ1ENhZ8bHYPlyQjVSpwSNyExLRtI
         TRk/mpI+7Bmc+xeUwuBMr/L8CAzDR2+U3DFyLITLWUmAU4FxWAw3vrHeE4ZPgdeBsta7
         EZxgZcYXZF30CIa6NiBGnH+GwF1zs+Neu9h2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=XWmb1f7PM5gylkcUC4llJGNYAJAYfNUGl+WHSAdCt6gkcCkp17eTxzuNuVlzJiKjx5
         IHXC0bkLEpcoCyBbbuH8twrhV6kMa8BMSduBDmAoWNFU9aKH89ajGVXF27xK48uPNL0+
         jJSoG+64idxG7DcK4ezLtwWRKdxFCHXSBSZ1A=
Received: by 10.229.228.146 with SMTP id je18mr22996qcb.13.1281612927664; Thu,
 12 Aug 2010 04:35:27 -0700 (PDT)
Received: by 10.220.172.67 with HTTP; Thu, 12 Aug 2010 04:35:27 -0700 (PDT)
In-Reply-To: <AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153366>

On Thu, Aug 12, 2010 at 12:20 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Aug 12, 2010 at 09:23, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>> [Sorry for the Cc spam; I lack the time to conduct individual messag=
es.]
>>
>> I compiled many topics in pu and ran the test suite on Windows,
>
> A Windows smoker would be useful :)
>

I guess I could look into setting one up. Where would I look for the
most up-to-date instructions on doing this?
