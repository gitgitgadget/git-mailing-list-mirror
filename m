From: Tim Visher <tim.visher@gmail.com>
Subject: Best CI Server for Git?
Date: Mon, 2 Feb 2009 15:58:55 -0500
Message-ID: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5u3-0007yq-Tj
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbZBBU66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 15:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZBBU65
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:58:57 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:42923 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZBBU65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 15:58:57 -0500
Received: by yw-out-2324.google.com with SMTP id 9so604382ywe.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HkHnazc4Ba/YSya/WjqEC+bagqbH/GUUPSlUZoaeJ6o=;
        b=S3fPCGpO502IoL4BLtqKfqPX7ZqXPAiIZ8R7BeeB9KNNKmuFpxdM7tAD01tYxK9FFN
         rfC0vWXAOp4Xy5mLIgkqedxNd/LlQLPh6fyd3tPBI/J6+pqIG0zya09b6zH67ncklIAV
         VVmxb5xStbJsXC3bzDYhqarRlKJrgbxhp6LWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kQ9+POx3kiin6j0RzcNRXCJzqyyI7MILpl0vjsg1lTFn3OiubDQPEuIke9WQX5hDfj
         livplHNHKG1YDB7LnuzJ296zDpFlG1GPaqVbvyLiCS9CHjMPoQjWZmNtQYhCabRO0Nv/
         5ii0kqFlcha9omo+1HOtenZxJwuZRWj8k8oSw=
Received: by 10.100.11.14 with SMTP id 14mr3168843ank.89.1233608335618; Mon, 
	02 Feb 2009 12:58:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108121>

Hello Everyone,

I'm setting up a CI environment for my team and I'm wondering what CI
Server works best with Git.  I'm actively considering Hudson and
Cruise Control and I'm leaning towards Hudson because of a demo I saw
Andrew Glover do at my local JUG.  It looks like it's not really
'officially' supported in either tool=E2=80=A6

Thoughts?

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
