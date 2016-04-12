From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 16:42:18 +0700
Message-ID: <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:42:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apuqU-00069k-C2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 11:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbcDLJmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 05:42:50 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34001 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbcDLJmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 05:42:50 -0400
Received: by mail-lf0-f46.google.com with SMTP id j11so17177505lfb.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c2RUVrJOKwrmWvU5wFdFVaNYfvY3LadtaPKZtKTLJpc=;
        b=rDx9BQGSfSnrHEqsBim9iJnXEyBdWI1B90/Goq6CEx6m6MnEDgFk6pnNfpO/lvbQaL
         /9VjQaaysRl/jz8zAuD5dCVT5egECMrtNuogAZP7HpsEA4cF2HQcK3HukchkHylhorhm
         /APDKoC4kyi+Gkrh6x9cxJCVx2fAnsdZAqxc7HOCUkswVOkYqY4v9RjutyxLvzud5f57
         8Zm1hk+ouMM6L85F4jwr/mCrTUxDgeABUwrPQIqtOOYIL4G7bBfX1bTl36QLOWU2i5lU
         7D2JCbJ3K9xFcunu1jdQpCHbUNznmg6kBgmth0LQz9i/lm8/rHlTFz0B6qMbFP8mrY6r
         DPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c2RUVrJOKwrmWvU5wFdFVaNYfvY3LadtaPKZtKTLJpc=;
        b=HuJrNeC018AldD8AVQvj3gqdakVZNiVBz5mpZqoRe5b//hloz7tGYyYGXpu+rgfm3T
         IeMO+FlibDoPjaP2rBgYoObF0Ks0IGnDyPJqppsAQIJFz5v73ufxz5VqL6tIDQmDh77H
         stojDhhbydpM8mngFht60DdUjztQFGw1MUPTIKmOp1cn9qi727MVGbWmtH4jPQd0PZF0
         gNsEzsxLIgbHHWOyC94/IxaDtLM/IfCOeuq/6r/G6bT12akc4FP8IiG61vXd5WtDlGou
         e2I3RVasWqdrfa5fuCynaZLrsx8xRDSIF3tXGfWNTEDPt4yN3sir8FH8Zo29aDVDoTvn
         28vQ==
X-Gm-Message-State: AOPr4FXnMK+eLLV5GPVJw9rsH9mkk7M7aLF9G6Hq+l6Gh3w/RDIhuObAANvmPVtnWz0eMA1YU0zXrp14sIvruw==
X-Received: by 10.112.85.43 with SMTP id e11mr1051677lbz.80.1460454168575;
 Tue, 12 Apr 2016 02:42:48 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 12 Apr 2016 02:42:18 -0700 (PDT)
In-Reply-To: <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291252>

> On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
>> Hi Greg,
>>
>> Thanks for your talk at the Git Merge 2016!

Huh? It already happened?? Any interesting summary to share with us?
-- 
Duy
