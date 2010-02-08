From: Mark Lodato <lodatom@gmail.com>
Subject: A Visual Git Reference
Date: Mon, 8 Feb 2010 14:34:21 -0500
Message-ID: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:34:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeZNp-0004y5-FW
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 20:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab0BHTew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 14:34:52 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:50750 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab0BHTeu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 14:34:50 -0500
Received: by pzk2 with SMTP id 2so198393pzk.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=a4FIdZW6uUbn6rEqcNi4T/VNLKYmrJDRhEzNNyb97hE=;
        b=BMrWYZ3jnCtB+nwQK8IsgFt34sUpPvgU4VR+KAyECyvwTSR9Pdd+PLotLd6W6Cqldr
         HttGhUXL+GKtHDorcZbKu3OSPllDvsZGftlz6b3Th/Ues0jOTSPUP6+X+Ay0Z2A1Y5Sj
         B28ZzaMtS1y6jWy9N3hzAZ6spcEK3dFk3Cjhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=TE6t2xIKkJvRbq2NiVlI4mroN5686Azt/pVaTMJqzFHPH4012NiOhCgoh1AM+55oR6
         3wz8M7jqzziCoJ1GRIibyq7Wuzp97+CV68neXAI+76JxyouLjkpA/3EaJJ1F/oXFV8vc
         7Ew6QN7DCn8c+tgxDdJZhgCPNv7F2b1cqbjTI=
Received: by 10.114.187.4 with SMTP id k4mr1028927waf.32.1265657681111; Mon, 
	08 Feb 2010 11:34:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139307>

All,

I put together a "Visual Git Reference" containing visualizations of
the most common git commands, for people who prefer to see images over
text.  It is designed as a reference, not a tutorial, so readers need
to have some amount of experience before the page will become useful.

URL: http://marklodato.github.com/visual-git-guide/
Git repo: http://github.com/marklodato/visual-git-guide/

If you have any feedback or suggestions, please let me know!

Cheers,
Mark
