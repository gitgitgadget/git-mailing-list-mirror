From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: updating 'rough' rule count
Date: Mon, 13 Apr 2015 01:04:36 -0400
Message-ID: <CAPig+cQ3z_UuUMZE_jUGbv1_3Fu_32GSw2ysSixw4VE0opz27w@mail.gmail.com>
References: <20150412234720.GA37658@Serenity.local>
	<CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
	<20150413042644.GA39596@Serenity.local>
	<CAPig+cTgNzO5NGabOsaSZOq7Y47OBXJz9mnS-MfpoQ2MANzrng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Julian Gindi <juliangindi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 07:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhWY7-0000Ns-I4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbbDMFEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 01:04:38 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33193 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbDMFEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 01:04:37 -0400
Received: by layy10 with SMTP id y10so48832678lay.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 22:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lNPmvoCOi4z5YGlZQN3elQ5E2vUiqHrwkm4O97RKKYw=;
        b=k3kAufjBUGP2ZFaC3tLhg4nNLJpS179SucSez/vjMMxo0NS1X/sdUorCa5F87fVstQ
         KrReJfTeB+JnThUTSIhqfYiMd420Oerd8z8Vk0pCe6vVlJ+Ssr6B53uvs6WL71FZAn6y
         H70a14su0NdEBxZIP13GY9Msx1UkdlM0X0a768CyG2rqi1xomuusly58QTnx2r+S67yH
         CQmhjYWxmrUaXa9XgLixCnMWQpbKTW6SfeqocXQl/H8AVpftf7dalw84+22xFD0JkqE8
         gqjW2AKyW7R54i5TB8fly/R2awVD90q5fuziulk097N9gKUMd5sSz+pwZyPJNQAUCNeY
         fGSA==
X-Received: by 10.152.2.130 with SMTP id 2mr11338677lau.120.1428901476363;
 Sun, 12 Apr 2015 22:04:36 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Sun, 12 Apr 2015 22:04:36 -0700 (PDT)
In-Reply-To: <CAPig+cTgNzO5NGabOsaSZOq7Y47OBXJz9mnS-MfpoQ2MANzrng@mail.gmail.com>
X-Google-Sender-Auth: cquandSUPh5dcFWInSCNcLidunQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267064>

On Mon, Apr 13, 2015 at 1:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 13, 2015 at 12:26 AM, Julian Gindi <juliangindi@gmail.com> wrote:
>>     Changed inaccurate count of "rough rules" from three to the more
>>     generic 'a few'.
>
> Imperative: s/Changed/Change/

I forgot to mention the unusual 2-space indentation of the log
message. It should be left-justified.
