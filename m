From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 13:19:15 +0000
Message-ID: <200703051319.17046.andyparkins@gmail.com>
References: <17895.18265.710811.536526@lisa.zopyra.com> <200703051213.52513.andyparkins@gmail.com> <20070305123348.GB3481@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 14:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOD6E-0008Rg-8x
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 14:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467AbXCENTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 08:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933470AbXCENTX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 08:19:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:64525 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933467AbXCENTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 08:19:22 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1754374nze
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 05:19:22 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D3IVEtRuRuf5jClEHUwY8/hkvDl3A3T4zunQO3fGnwqkyUoLV5TIt/imGwfzigLRoo8oTEvqdijxgVTFFYcEAfsuw8gF7UL+pjv7VAfoBPgLmTcGPSJXjip/Bf8MCsCBkUVMeGQTfA/wS7qdAhLfI3pGx9ut/dmgIDRy1O3RmvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PExnNF2SOdg1nMAnANi9ygcEUpLizArucKBTxJQZG6dK8lFbFz0A5lQ2C32jEdJFlmc9PIASQK7eEuQurkuzYlwlUmKYZ81Elh7ink/4HTZquplGlXjMSiU75ZzvCgOcRK5y+xuTLetCLtNoNBp3lsbgCMYf/rvbMc9sz8poON4=
Received: by 10.64.125.17 with SMTP id x17mr3434060qbc.1173100762028;
        Mon, 05 Mar 2007 05:19:22 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id k9sm22837667nfc.2007.03.05.05.19.19;
        Mon, 05 Mar 2007 05:19:20 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070305123348.GB3481@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41442>

On Monday 2007 March 05 12:33, Karl Hasselstr=F6m wrote:

> Now, obviously "make" isn't such a make tool, since it goes only by
> timestamps.

Perhaps this will help you:

http://kolpackov.net/pipermail/notes/2004-September/000011.html


Andy

--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
