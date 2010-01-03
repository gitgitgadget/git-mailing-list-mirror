From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Smart-http documentation: add example of how to 
	execute from userdir
Date: Sun, 3 Jan 2010 10:11:46 +0800
Message-ID: <be6fef0d1001021811x2a2a95j3ebbd19091abc60b@mail.gmail.com>
References: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com>
	 <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 03:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRFwe-0003DK-Eq
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 03:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab0ACCLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jan 2010 21:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219Ab0ACCLs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 21:11:48 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46274 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab0ACCLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jan 2010 21:11:47 -0500
Received: by iwn1 with SMTP id 1so10164025iwn.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 18:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n+FZVmAncbBDjt+mhiB7eEtiPRTP8KPRsi47lD8xGJI=;
        b=N4a2lU2lBbA0uH2bnBVzrKHqQK4ZCTXmOxHQqkq8+Q1QObfC1OKIOLwep5Ym0HAk0g
         SK1Tqg+OHpYpl0huU7B/6A779tU+xuprl9uBdEMdlY51/F7hQPqvbDnhkH0bu/OBZiil
         mHw2QssQirNZR+M2+jXTINK0NVxkX05Olv4OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KzxyrK0m9eDJfmZMFKaFFQ6ygstqnafpI0VMNmj2QXw7hNTzZ4K6l02xTYCfqhRbwj
         muhw0OyYkwFhBoI+3gmT/I0uEor4jBMqU9qNen5IVy0jYFS8ptRj1+MP1+d7MXqaspjr
         c9btKoCCsKNnU9Xv1I64IZ/AeZkDP2j7wTlao=
Received: by 10.231.24.142 with SMTP id v14mr1424446ibb.55.1262484706819; Sat, 
	02 Jan 2010 18:11:46 -0800 (PST)
In-Reply-To: <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136061>

Hi,

On Sun, Jan 3, 2010 at 5:18 AM, Tarmigan Casebolt
<tarmigan+git@gmail.com> wrote:
> Smart-http may be an attactive and easy way for people to setup git
> hosting on shared servers whose primary web server configuration they
> do not control. =A0To facilite this, provide an example of how it may=
 be
> done.
>
> cc: =A0Tay Ray Chuan <rctay89@gmail.com>
> cc: Shawn O. Pearce <spearce@spearce.org>
> Editing-by: Tay Ray Chuan <rctay89@gmail.com>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
