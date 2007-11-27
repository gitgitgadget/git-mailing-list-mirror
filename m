From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 17:36:12 +0100
Message-ID: <81b0412b0711270836g775796c0mfeb76191dc78762d@mail.gmail.com>
References: <200711271127.41161.gapon007@gmail.com>
	 <200711271231.51270.gapon007@gmail.com>
	 <81b0412b0711270503s7e69be3bn151cfa58b8067f35@mail.gmail.com>
	 <200711271445.47695.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 17:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3QP-0006J2-FH
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbXK0QgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbXK0QgU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:36:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:40113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbXK0QgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:36:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1021238nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VVvxwjVXXL6K5yRyK5t3/LCbzN44kdc90XJeGH/DL+M=;
        b=KbkuPBT1IARkrMBvyj2fFQTYNIp8v7gnXuqAyalIdBCRaN59fhKMA54YMKDN+kLQoXyfUMdzODoMkohE4Xy3RTHCPV0tkFHrJsytvp3ITF936YbzXKkUeeDqCHdBWPs7cRph1BvtBXcKu1BLNqwDt2XBempHJ1Z0Se96WjDmfN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jKgXcwy0paQI9XVmkPK8sNwtg0Q6uDt3DI62dXVHRmYiw6M+MNNOEwFDCDfPf9mMB+BSU9q6eF0qqS0jWrv46/sXx52YZCtw5yhMylTcfwk9J3ahrvYZa5Nrv3wNNYyLilgUcftwd3N3FEi8c8CsZ3Gh8k/W8j/tCvfD/Vp96zw=
Received: by 10.78.21.7 with SMTP id 7mr4493022huu.1196181372073;
        Tue, 27 Nov 2007 08:36:12 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 08:36:12 -0800 (PST)
In-Reply-To: <200711271445.47695.gapon007@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66237>

On 27/11/2007, gapon <gapon007@gmail.com> wrote:
> > Well... It is known problem, for one. That user B of yours, did he just
> > cloned user A's repo?
>
> yes, i can paste here all the scenario step by step if you want

No, thanks. It is easy to reproduce
