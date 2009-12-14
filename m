From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: git --version wrong
Date: Mon, 14 Dec 2009 07:17:37 +0100
Message-ID: <28c656e20912132217u4e1aeb27y9b957c8e75210e9e@mail.gmail.com>
References: <26770625.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: oshybrid <oshybrid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 07:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK4Fc-00071Y-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 07:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZLNGRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 01:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZLNGRj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 01:17:39 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:20863 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbZLNGRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 01:17:39 -0500
Received: by ey-out-2122.google.com with SMTP id d26so783569eyd.19
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 22:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R2HND0u4BCn4A1b2eDWTq+JlEguu29UXdPAoez6n480=;
        b=Yng3FFQjMUot7wGg1EC8Bf3x3Bf40Wg2iDOcdrGlDFwMVGJHmRhG8F0gSd2o5RhXq6
         GN/ez23NQdDm6ws9xtYDIm8cjSrARk1TnxVgPQ8DociJrJmiFL1p1AqP3eXMcgDu/rbO
         i+tjREzmNc1wiVjniL4x7qVz6BkNH5UCtnT3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iN3LQ4ZLdfAdthtLKzlB2njWsito6ewHzFMj757rsbFn/89tzOozh7sC+xuN6Zx37n
         Ug9ouv3VkWoCxNfHNZB5g6KliaKMt00P7y5YJeDF3/hzBJgZBtR6xF2IJD3krFONkptL
         SxeuJUYE1KShM3i9S6eGZd4vrXWLBRCA+aBgs=
Received: by 10.213.100.217 with SMTP id z25mr2978874ebn.88.1260771457862; 
	Sun, 13 Dec 2009 22:17:37 -0800 (PST)
In-Reply-To: <26770625.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135168>

On Sun, Dec 13, 2009 at 23:51, oshybrid <oshybrid@gmail.com> wrote:
>
> After i Instal 1.6.5.5 my "git --version" =C2=A0still shows 1.6.0.5
>

How, exactly, did you install it?
What's the output when you type "which git" at the command line?

// Ben
