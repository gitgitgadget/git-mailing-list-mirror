From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: GNU patch: new 2.6 release
Date: Sat, 14 Nov 2009 09:45:11 +0100
Message-ID: <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
References: <200911140109.34202.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 09:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9EG0-00014B-Ek
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 09:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbZKNIpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 03:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbZKNIpH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 03:45:07 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35631 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbZKNIpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 03:45:06 -0500
Received: by bwz27 with SMTP id 27so4203530bwz.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 00:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OH3xUxSb1CSsFqm4kw4L0nga60M+ik5Kcsgt943vL60=;
        b=yEruRGtTTsdyx2TdZ44ODHIZyCQTaKvfukr8LD7NgOwFrECAPcEmnRMgSscg885oBl
         jJxIpd+Hf+7YjwUkyKRvxyqBlCZZwRuOQjrT8xAA81bBNU1IWQn1CV83iLThtb4h91G7
         TOR8jdT/dM3wvHgGP+uuvFmEDdMmua3BcWwb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FckWlsOEVkxDXrEQ0kAt5QUNNapm3S7+tXNHhoy8avUmMppR8sqg4z7jfqSELANSM3
         UWtHkjc8pkOWBdFFxYPYA46TnhLc9wgJ9wwBdVvvjYeDCWydV90SSN/dVkFP1GIEGzRo
         4V4FpYmEv5CUhuSbL+UUzwnzJxfh8pvzF7jLA=
Received: by 10.204.162.137 with SMTP id v9mr1661931bkx.60.1258188311051; Sat, 
	14 Nov 2009 00:45:11 -0800 (PST)
In-Reply-To: <200911140109.34202.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132862>

On Sat, Nov 14, 2009 at 1:09 AM, Andreas Gruenbacher <agruen@suse.de> w=
rote:
> I am pleased to announce my first release of GNU patch,

Nice to see a new release.

Do you have any plans to support git-style binary patches?

That would be very useful in a workflow when you work in git (and have =
some
binary files in the repository), but need to commit your finished work
into another VCS (such as Clearcase).

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
