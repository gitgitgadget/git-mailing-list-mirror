From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Mon, 01 Jun 2015 17:10:24 +0200
Message-ID: <9A423AE7-27D6-402F-80C2-C9DA7AF08033@gmail.com>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com> <556C0BFD.3060806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: sbeller@google.com, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: git@drmicha.warpmail.net, Ralf Thielow <ralf.thielow@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 17:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRMK-0004P9-9g
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbbFAPKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:10:32 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36055 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbFAPK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 11:10:29 -0400
Received: by wibdq8 with SMTP id dq8so32566451wib.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=8ZAqKYcAHlhHueVZegXLcK4v0DlhBd8GQqAdiICL7xE=;
        b=OWX1H1AeuTac5Sl1Ksgb/C7qsPVrcfT9ebh6MWWsfAjGYxwLsiu4Z3FJ3nC7GXq+1U
         ubAtY5OOKDU9eJCYO34FHkLpiUagEeWscVcS4K8wypp3fMegO35Y7A0Qy7YklsN2YhIk
         4Hi4ftjquxEhu0/QRFgfk8iTVfacwVhq6RjefhPXN0vZAl4+5AFTO5JVx8OhxT3zwy+i
         psVz04Z7BvsHObTHZeVlYu737sJVlbzcbpQXekfQI16YCGGXtVYJOIfcpQr9KGTL2w9I
         vzpSjcb/p9Z4LavxUzSwagbdawgOKqd6rKxhUIHhTD373NXqLBwhVk2NkyaJyx0ErD+J
         4pCw==
X-Received: by 10.180.90.236 with SMTP id bz12mr21650119wib.33.1433171428269;
        Mon, 01 Jun 2015 08:10:28 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i577AB4B1.versanet.de. [87.122.180.177])
        by mx.google.com with ESMTPSA id u9sm22338227wju.44.2015.06.01.08.10.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 08:10:27 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <556C0BFD.3060806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270423>

 

Hi, 

>>  #: sequencer.c:661
>>  #, c-format
>>  msgid "git %s: failed to read the index"
>> -msgstr "git %s: Fehler beim Lesen der Staging-Area"
>> +msgstr "git %s: Fehler beim Lesen des Indexes"
>
>Now we have to decide whether we flex "Index" like a foreign word in
>German or like a German word:
>
>der Index, des Index, ...; die Indizes (pl.)
>
>or
>
>der Index, des Indexes, ...; die Indexe (pl.)
>
>I'd vote the former.
>

You can use Indizes and Indexe both as german word. I would prefer Indexe as its easier to understand.

Phillip 
