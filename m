From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git
 repo somewhere?
Date: Tue, 30 Mar 2010 21:56:27 -0500
Message-ID: <20100331025626.GA13501@progeny.tock>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>, Eric Blake <ebb9@byu.net>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 04:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwo6P-0000LM-SH
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934Ab0CaC4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 22:56:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44897 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082Ab0CaC4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:56:15 -0400
Received: by gyg13 with SMTP id 13so2541181gyg.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S+Y8ZXNZ4fCi/LJEEYWy7GmiyZu5KEjL/id5IkRIqdA=;
        b=jYBwZQTDMxu+/VGM9x225RL8aqTDz9eCoTS0akZGMfRumeF28PfvIL/lbKbRXGU1dK
         DW3yIo5LDC2lqt7jIzNEwaUC1RYovdA7+8eIypFKq+2A2wX16SS6v9arDTFQI1Fi8+hu
         rtCGwPiaqKZ1Qj7W+Bg3IMwmjs4uJ7Yq1dC3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wp0/g8ef9Ow0fLvVJia2ffz/QaFZmtQceTj5k13juQcjW7C5MiRzlvoIznXlWfgh4V
         lISb/mNcWhR8CorirVpoq7hydU3gdJsRHxebB1t9ExzOqZwXWiH6yfq/8YKtmUT/zPxT
         xV6KpNGzjXjGBvhB2fG9taLe8UhiKbKbOoM94=
Received: by 10.101.217.11 with SMTP id u11mr5849659anq.243.1270004170491;
        Tue, 30 Mar 2010 19:56:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5592561iwn.8.2010.03.30.19.56.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 19:56:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143638>

[adding a few relevant cc's]

Jon Seymour wrote:

> Does anyone maintain a git repo with the patches used to successfully
> build the cygwin git packages?

I think git.git is the canonical repo.  On cygwin.com I don=E2=80=99t s=
ee any
package more recent than 1.6.6.1 so I suspect no one has packaged a
recent version yet.

I assume reports and patches would be welcome.

HTH,
Jonathan
