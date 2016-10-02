Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686B61F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 22:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbcJBWXw (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 18:23:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33058 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbcJBWXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 18:23:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id p138so11998688wmb.0
        for <git@vger.kernel.org>; Sun, 02 Oct 2016 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nDvoUG752wGprC7+/Fimg/ReP+SAt98U9ifDw3NnkCk=;
        b=t4nN2AMVi/49CP+3PbkJEtjVtLVCjSBvnYJdaqfWXLhczml33w/VFBzlL16+nvPR0t
         73SVee9g+3v+UL2bUikD7bSDERwe1MEBUWMKau8Y0WZPhylldFAikyO8/fmoNp3/7YFt
         gycwlo+Z9roiV0SzzMLjcFkC3el2KJypo41Zv3F/ywSIJkTnihvG91k997NVsNk5gFw0
         N6ylcxi3dLw1/cfZCZq2vYufr17n9y5OKB+6uuWWryzkt+5vcjVDOErzE9vkXeLiDpS7
         hQ8DqDOFhs8oR6QXD0KfJg6Ys5T8/sQ9XsVuAF5ZA81+JTi60TiavhVdSpFkaRaXRr0+
         +7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nDvoUG752wGprC7+/Fimg/ReP+SAt98U9ifDw3NnkCk=;
        b=lAbzXcTv2VugLFnrJ6yxo6xY2p0cGuIYnI/SiomCU23zbpjc3+myKfhFx2f9qNa6mt
         fqVsZ+Uiypc+M1Gn5UmaVGP4pHlAyQAQlOSkPgNjNbQzEBfxes4bnkSEF8aVxj6hoHhm
         KDSBSh1U2LLfcVHWVAYl2PJdppQ055ztukcgG2p6op5/qxBTXIGYboo2kvPdD7cugMWQ
         hLbWuHq3dLFy9rF6zqwBSQjtNyOaBpV03E5L9d4dtXX8YqhPMZz+yKWhWsrzYSypi40h
         rrwmpGwXi1ivUMvCdM9yWCHa450Tv9Qv5/8fHmiZgVHqjM8M1sIu5O0nc7KRxm+r8TdL
         9f8Q==
X-Gm-Message-State: AA6/9RnoeFVzmslJbNxCjFHogK7k8ERI2ggTZG7B/cLpiZetoYUSDIYCJe08pipRxz+8lA==
X-Received: by 10.28.207.77 with SMTP id f74mr5028057wmg.35.1475447029996;
        Sun, 02 Oct 2016 15:23:49 -0700 (PDT)
Received: from [192.168.0.136] (ip5f5be580.dynamic.kabel-deutschland.de. [95.91.229.128])
        by smtp.googlemail.com with ESMTPSA id ce6sm31265236wjc.27.2016.10.02.15.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 15:23:49 -0700 (PDT)
Subject: Re: [PATCH] l10n: de.po: translate 260 new messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20161002165946.19656-1-ralf.thielow@gmail.com>
Cc:     tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
        phillip.szelat@gmail.com, magnus.goerlitz@googlemail.com
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <0de216d5-8a47-bd1d-b9d6-8346a62bc489@gmail.com>
Date:   Mon, 3 Oct 2016 00:23:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161002165946.19656-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

many thanks for your translations!

I reviewed them and only have some minor comments:


>  #: bisect.c:967
> -#, fuzzy, c-format
> +#, c-format
>  msgid "%s was both %s and %s\n"
> -msgstr "%s folgt sowohl %s als auch %s"
> +msgstr "%s war %s als auch %s\n"

Maybe keeping the "sowohl" here:
"%s war sowohl %s als auch %s"



>  #: setup.c:989
>  #, c-format
>  msgid ""
>  "Problem with core.sharedRepository filemode value (0%.3o).\n"
>  "The owner of files must always have read and write permissions."
>  msgstr ""
> +"Problem mit Wert für Dateimodus (0%.3o) von core.sharedRepository.\n"
> +"Der Besitzer der Dateien muss immer Lese- und Schreibberechtigung haben."

I would translate "read and write permissions" to:

Lese- und Schreibrechte



>  #: builtin/fsck.c:606
> -#, fuzzy
>  msgid "show verbose names for reachable objects"
> -msgstr "unerreichbare Objekte anzeigen"
> +msgstr "erweiterten Namen für erreichbare Objekte anzeigen"

Maybe "ausführlich" is the better choice for "verbose" here?
"ausführliche Namen ..."



>  #: builtin/merge.c:960
>  #, c-format
>  msgid "Bad value '%s' in environment '%s'"
> -msgstr ""
> +msgstr "Fehlerhafter Wert '%s' in Umgebungsvariable '%s'"

I do not know the context but I would translate it to:
"... Umgebung '%s'"



>  #: builtin/push.c:546
> -#, fuzzy
>  msgid "option to transmit"
> -msgstr "nichts zu committen\n"
> +msgstr "Optionen übertragen"

Is the plural form correct in this context?
Maybe "Option übertragen" ?



>  #: git-rebase--interactive.sh:147
>  msgid ""
>  "\n"
>  "Commands:\n"
>  " p, pick = use commit\n"
>  " r, reword = use commit, but edit the commit message\n"
>  " e, edit = use commit, but stop for amending\n"
>  " s, squash = use commit, but meld into previous commit\n"
>  " f, fixup = like \"squash\", but discard this commit's log message\n"
>  " x, exec = run command (the rest of the line) using shell\n"
>  " d, drop = remove commit\n"
>  "\n"
>  "These lines can be re-ordered; they are executed from top to bottom.\n"
>  msgstr ""
> +"\n"
> +"Befehle:\n"
> +" p, pick = Commit verwenden\n"
> +" r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
> +" e, edit = Commit verwenden, aber zum Nachbessern anhalten\n"
> +" s, squash = Commit verwenden, aber mit vorherigem Commit vereinen\n"
> +" f, fixup = wie \"squash\", aber die Log-Nachricht des Commits verwerden\n"
> +" x, exec = Befehl (Rest der Zeile) mittels Shell ausführen\n"
> +" d, drop = Commit entfernen\n"
> +"\n"
> +"Diese Zeilen können umsortiert werden; Sie werden von oben nach unten\n"
> +"ausgeführt.\n"

In my opinion fixup needs a more detailed description here.
Something like:

"fixup: wie \"squash\", aber die Commit-Beschreibung vom Vorgänger
verwenden\n".

or:

"fixup: wie \"squash\", aber diese Commit-Beschreibung verwerfen\n".




Everything else looks great!


Kind regards,
Matthias
