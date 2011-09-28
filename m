From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 18:59:59 +0200
Message-ID: <vpqfwjg61rk.fsf@bauges.imag.fr>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
	<7vty7xttxh.fsf@alter.siamese.dyndns.org>
	<CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
	<4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
	<1317195719.30267.4.camel@bee.lab.cmartin.tk>
	<alpine.LNX.2.00.1109280555460.25187@bruno>
	<7v1uv01uqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?iso-8859-1?Q?Mart?= =?iso-8859-1?Q?=EDn?= Nieto 
	<cmn@elego.de>, "Olsen\, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:01:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8xVd-0002c9-70
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab1I1RBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:01:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36816 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351Ab1I1RBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:01:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8SGvv07002306
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 18:57:57 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8xUG-0005fi-1J; Wed, 28 Sep 2011 19:00:00 +0200
In-Reply-To: <7v1uv01uqm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Sep 2011 09:45:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Sep 2011 18:57:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SGvv07002306
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317833878.01835@+VP/JI6vWaCvU0Qv846fHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182345>

Junio C Hamano <gitster@pobox.com> writes:

> The world is not so blank-and-white. Trust is ultimately among humans. If
> this message is not from the real Junio, don't you think you will hear
> something like "No, that c6ba05... is forgery, please don't use it!" from
> him, when he finds this message on the Git mailing list?  If he does not
> exercise diligence to even do that much, does he deserve your trust in the
> first place?

This assumes you will see the message, so while it does solve simple
attacks like sending an email with a fake From: header to the actual
list, it does not solve more advanced attacks like compromising
kernel.org's mailing-list server to avoid delivering you the forged
email.

I know I'm being a little paranoid here, but given the recent events
with kernel.org, maybe we should be that paranoid :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
