From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 12:39:23 -0500
Message-ID: <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
References: <201002171627.57599.arvidjaar@mail.ru> <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:40:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhooe-00021Z-KU
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 19:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0BQSj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 13:39:56 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:64524 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab0BQSjy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 13:39:54 -0500
Received: by yxe38 with SMTP id 38so5589058yxe.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iPNCFvfF87QE7SaBFc0VbKN9DkDPzFxOKPWDly34kqM=;
        b=sLxQUrriDLZqO2Go6obW+GHpMMqxpVLJbN9KTvdb8673weqWM+UPNKKiF0NQecntoI
         Ck5lx69jW+6DEfE82P281SEPzbMoA/UlpHbC/TZapUfCYj8W2bRJt9+QEFUtyFN3qRk+
         +hlV10R3wtkLHDMHitxntEC/8FDUt58Z3EHsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=psgp5hd51FvFUQxeiaIWLtqmsC7CswlGXwVbj05KuVRFBQskbIZ83dtIRqF5OeKdSm
         l/iM1mLsfe3wM8W4YS4W0JLG6ievC/pRrpv1Lo1YQE4b2pcsPU+eB160SzaMx+PLPO/G
         MPqhAjSCQoSLcH9KnY7+lhBe3JqNdyCaE0tXg=
Received: by 10.150.118.11 with SMTP id q11mr12047693ybc.40.1266428383187; 
	Wed, 17 Feb 2010 09:39:43 -0800 (PST)
In-Reply-To: <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140243>

On Wed, Feb 17, 2010 at 8:39 AM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> On Wed, Feb 17, 2010 at 9:27 PM, Andrey Borzenkov <arvidjaar@mail.ru>=
 wrote:
>> {pts/1}% l .git/refs/heads
>> local-mdv =A0local-mdv.stgit
>
> have you tried
>
> =A0$ cat .git/packed-refs
>
> ?

The documentation is still lying though :)

Avery
