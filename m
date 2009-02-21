From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Best CI Server for Git?
Date: Fri, 20 Feb 2009 23:59:19 -0500
Message-ID: <c115fd3c0902202059j3dfa3061w1c99626a35c69ca5@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
	 <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
	 <c115fd3c0902041123j4a16d666r6d1fbb9917184b2a@mail.gmail.com>
	 <c115fd3c0902180847p8addb28p485618322d0e5806@mail.gmail.com>
	 <ae63f8b50902200215k5aeac468n1300597ef1830736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LajzD-0000w8-Te
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 06:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbZBUE7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 23:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZBUE7X
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 23:59:23 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:43427 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZBUE7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 23:59:22 -0500
Received: by bwz5 with SMTP id 5so3244526bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 20:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y5h1Mpe6Ne+cY37N0a1N8Vz5sYY6YQBWxGGk4kd7nYs=;
        b=SZ2XgvEax8z7lzd7TnoH4iLL3ISYGUNMx0WHlWeNF18YdHt/sNLrGnq1DmXLzDHdxv
         LpGhwlfKVIgdr7kc9HndgGqYKxT6xEzLKC/EYFEVbH8XqtTf4SDx7RvlNWxWygSNLwBV
         HoP0z0HPSPpAzjFbIBqWKUUbYXV0HP1DEk3f4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Si0QyGfKrHui/i6t0zcLDp6gjYZVi1vXdsutt3fT7/Jtygzhbw2VgL9R6gjgesL834
         3BSGRLtjrgRqq7SZACsUVw9gwBudPyVY9KzQzuRebAMcFeDjEHA3qhHF/UKpBTwAEZ26
         Aqw2AudwXODF0mKB4biX6WcrubPYkhnENo850=
Received: by 10.181.192.11 with SMTP id u11mr554284bkp.50.1235192359875; Fri, 
	20 Feb 2009 20:59:19 -0800 (PST)
In-Reply-To: <ae63f8b50902200215k5aeac468n1300597ef1830736@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110926>

On Fri, Feb 20, 2009 at 5:15 AM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:

> Did you consider joining the Hudson users mailing list?

I'm actually on it.

> Would you be interested in testing the upcoming 0.6 version of the Git
> plugin?

I'd be happy to.  The way I see it a CI server is nothing but icing on
the cake so if something goes wrong with the CI server the shop
doesn't stop.  If 0.6 solves the issues I'm encountering then I'm all
for it.  Is it best to discuss that on the Hudson list or here?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
