From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git filter-branch --directory-filter oddity
Date: Wed, 4 Dec 2013 17:48:26 -0500
Message-ID: <CACPiFCJQeK7+8Ob23HPrzhoSwuTiHdaz8NYhhn2ki-egzJT6dQ@mail.gmail.com>
References: <CACPiFC+nCj8VMqb+aK-C5gMyX6R0dDba1U1U49KTktF3WDQ9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:48:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoLFU-0000ny-7C
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab3LDWss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:48:48 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:62902 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab3LDWsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:48:47 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so12656757veb.40
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 14:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=C27Iqq+zXR1W8uYPZmOjJzAwy77DQOATQBhmvuShggk=;
        b=daAfyS6C6e08oMjf30W0hkDmKwk7lCG3I+bq5aaUcSdSgfbXtOlu55VLpp+gGZ1Ofx
         U7yDSTnRI1MD83vqg1hTSGqRZvc5W15EEZTwMulkFHx8pXawhHpDq702sikkbo/jkrKG
         tbpumLodMdPkYOQEX8Rd9tBkStd2YOPRsz4BaDV0gMy8bVYMIr/hstfflclrHnEKmeQU
         s8CiKh3zv++bhXfBvsssEnZ8lxevNLJI9ytgdTUicq8E6S2CRNrLG4IV4r0api1St/pZ
         wAae6442ZzQI64EhbHhbnEbD7+R3f7cyZcmrqQHvf02vlloPoIMrQ90xghKE1jYjk0zs
         14LQ==
X-Received: by 10.52.121.104 with SMTP id lj8mr3457400vdb.33.1386197327057;
 Wed, 04 Dec 2013 14:48:47 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Wed, 4 Dec 2013 14:48:26 -0800 (PST)
In-Reply-To: <CACPiFC+nCj8VMqb+aK-C5gMyX6R0dDba1U1U49KTktF3WDQ9ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238824>

On Tue, Dec 3, 2013 at 5:44 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Am I doing it wrong?

Looks like I was doing something wrong. Apologies about the noise.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
