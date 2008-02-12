From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/safe and kha/experimental updated
Date: Tue, 12 Feb 2008 17:54:24 +0000
Message-ID: <b0943d9e0802120954j4322e1d9o7796428f9480f9a@mail.gmail.com>
References: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Peter Oberndorfer" <kumbayo84@arcor.de>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOzLR-0006mp-Fa
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761022AbYBLRy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 12:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761307AbYBLRy0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:54:26 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:5583 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761022AbYBLRyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 12:54:25 -0500
Received: by py-out-1112.google.com with SMTP id u52so7433823pyb.10
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UhHJEjlGYz0y9pVS1c421AhvG05cBfnY3ZlpxeFCEIs=;
        b=t6bO31kK2ZYMe0ZUA9z6FxGCprCKQRyqCVholUqeKDfQpz3OcqUARNi0RA7bOwkKjeI+e0fZD97R/mkYLKYNST+Z1Ghvhi6rdW+RYWiMIp2w6u9i9K7G8zI6Fdg10pm8z7I/a+UE24IDZWDZDaZMm+h7GX38k+3w2455qh9aFVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ey2htzcvTu5b9n+Hr1M+rg8RRuhYasQ700LSUbx3vCeT9yIG782/P4lO3q9/cpNXQKviXo8ePc93uqj1AT+Q3h+VDYQ2hHWbrkMxS0u95SbORTK6AujkTTwv3H95XclQSp+RUUqA8vmscyHJm0bh3EFFmwcdeG7JVI2LqbT2XPM=
Received: by 10.140.169.6 with SMTP id r6mr1130875rve.210.1202838864300;
        Tue, 12 Feb 2008 09:54:24 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 12 Feb 2008 09:54:24 -0800 (PST)
In-Reply-To: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73681>

On 10/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Both branches updated. I've promoted some experimental patches to
> safe, and done some work on new and delete (will post the patches in
> reply to this mail).

Thanks, I merged them last night. I now have to spend some time to
understand StGIT as it's moving too fast :-). I'll try to put back
some of the things I use like the automatic invocation of the merge
tool during conflicts etc.

--=20
Catalin
