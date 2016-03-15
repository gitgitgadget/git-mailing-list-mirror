From: =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 22 new messages
Date: Tue, 15 Mar 2016 20:43:23 +0100
Message-ID: <56E865DB.5020103@gmail.com>
References: <1458061920-22666-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 20:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afusl-00082s-Di
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965844AbcCOTn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 15:43:28 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33279 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965824AbcCOTnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:43:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so160142185wml.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/tt2s0QQ0RqaMCdcor6sQ1+m6EnG+H5+gHultCBMzCA=;
        b=f35UNLbmkuGSV1xR4NZ1dW6BQQoSoNLwTKMyCZ6Hm8JROTOL9Vf91O/yDtabr9sRDP
         khIobHl7qwnsH/rWMZHZUTzHkCb59J1KsGndvt2OP1FjA06OQrshsoolMuB9GnJOEWhv
         /2Jq6sNYuQZJGuoyuEOwPagWXWoBBO2VCjUHrURxJ8eBat5rbbtBaWUtSDSl7MTSHY3k
         x8cy/Chz8cB+x15K/0QvAqvyd46U8EolGhklOAE4WGksgzaaeEt8hA+SK6d5aXFWosI7
         zLZ6bD6iO72hXkvhCQICPdQDDTJs7nnv+jsHKPW91ljDRB7d0I5FRLVyicACn23UTb0r
         IS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/tt2s0QQ0RqaMCdcor6sQ1+m6EnG+H5+gHultCBMzCA=;
        b=LPLVwsgx/kUKwGjxauFP3QuIkm07NFfIvYGmDbrUsqZhNcBCk0gbIOUYVVopId/2X9
         BRW8FxVlfzMypUk3fDVd1BAL0v8VoDPupToIlfGjNOr8T8KWba0aXVKoxm6D5nD2eL7S
         PNhX6pX/jJ7nldAvFk28/BuUocX+79nNCzkrz+WOYFtj+44QybHRYr2jc6U2VSocVn4h
         KdA2Si0EE1zronr5ZH90ZtORyV9q+qphrElBCDRLTKbR4l6rFh6Cqh0AVaaA2NpkYW0+
         yi4zlullxiV/yNwwuuQFrRUZG4Rfgw6mNDjMGC0C5jt6Dr6GAkLEdfivhp7rcenV33CH
         Ecsg==
X-Gm-Message-State: AD7BkJJJ8tmwknUhah+XSPFPR9Cx9e4neatI/cgUSMwUcZyjIOQIdixtmcjjJDEu9xdGCg==
X-Received: by 10.194.189.7 with SMTP id ge7mr31660216wjc.72.1458071002060;
        Tue, 15 Mar 2016 12:43:22 -0700 (PDT)
Received: from [10.30.1.49] ([193.25.36.92])
        by smtp.googlemail.com with ESMTPSA id ks5sm28495385wjb.13.2016.03.15.12.43.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Mar 2016 12:43:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1458061920-22666-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288901>

Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>

Am 15.03.2016 um 18:12 schrieb Ralf Thielow:
> Translate 22 new messages came from git.pot update in f1522b2
> (l10n: git.pot: v2.8.0 round 2 (21 new, 1 removed)) and a5a4168
> (l10n: git.pot: Add one new message for Git 2.8.0).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>   po/de.po | 68 ++++++++++++++++++++++++++++++++---------------------=
-----------
>   1 file changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index edee6db..7093139 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -1150,14 +1150,14 @@ msgid "unrecognized format: %%(%s)"
>   msgstr "nicht erkanntes Format: %%(%s)"
>
>   #: ref-filter.c:77
> -#, fuzzy, c-format
> +#, c-format
>   msgid "%%(body) does not take arguments"
> -msgstr "--worktrees akzeptiert keine weiteren Argumente"
> +msgstr "%%(body) akzeptiert keine Argumente"
>
>   #: ref-filter.c:84
> -#, fuzzy, c-format
> +#, c-format
>   msgid "%%(subject) does not take arguments"
> -msgstr "--worktrees akzeptiert keine weiteren Argumente"
> +msgstr "%%(subject) akzeptiert keine Argumente"
>
>   #: ref-filter.c:101
>   #, c-format
> @@ -1200,14 +1200,14 @@ msgid "positive width expected with the %%(al=
ign) atom"
>   msgstr "Positive Breitenangabe f=C3=BCr %%(align) erwartet"
>
>   #: ref-filter.c:244
> -#, fuzzy, c-format
> +#, c-format
>   msgid "malformed field name: %.*s"
> -msgstr "Missgebildeter Objektname %s"
> +msgstr "Fehlerhafter Feldname: %.*s"
>
>   #: ref-filter.c:270
> -#, fuzzy, c-format
> +#, c-format
>   msgid "unknown field name: %.*s"
> -msgstr "unbekanntes Argument f=C3=BCr Option --mirror: %s"
> +msgstr "Unbekannter Feldname: %.*s"
>
>   #: ref-filter.c:372
>   #, c-format
> @@ -1215,33 +1215,33 @@ msgid "format: %%(end) atom used without corr=
esponding atom"
>   msgstr "Format: %%(end) Atom ohne zugeh=C3=B6riges Atom verwendet"
>
>   #: ref-filter.c:424
> -#, fuzzy, c-format
> +#, c-format
>   msgid "malformed format string %s"
> -msgstr "Fehlerhafter Ident-String: '%s'"
> +msgstr "Fehlerhafter Formatierungsstring %s"
>
>   #: ref-filter.c:878
>   msgid ":strip=3D requires a positive integer argument"
> -msgstr ""
> +msgstr ":strip=3D erfordert eine positive Ganzzahl als Argument"
>
>   #: ref-filter.c:883
> -#, fuzzy, c-format
> +#, c-format
>   msgid "ref '%s' does not have %ld components to :strip"
> -msgstr "Pfad '%s' hat nicht alle notwendigen Versionen."
> +msgstr "Referenz '%s' hat keine %ld Komponenten f=C3=BCr :strip"
>
>   #: ref-filter.c:1046
> -#, fuzzy, c-format
> +#, c-format
>   msgid "unknown %.*s format %s"
> -msgstr "Unbekannter Commit %s"
> +msgstr "Unbekanntes %.*s Format %s"
>
>   #: ref-filter.c:1066 ref-filter.c:1097
> -#, fuzzy, c-format
> +#, c-format
>   msgid "missing object %s for %s"
> -msgstr "fehlende Objekte erlauben"
> +msgstr "Objekt %s fehlt f=C3=BCr %s"
>
>   #: ref-filter.c:1069 ref-filter.c:1100
>   #, c-format
>   msgid "parse_object_buffer failed on %s for %s"
> -msgstr ""
> +msgstr "parse_object_buffer bei %s f=C3=BCr %s fehlgeschlagen"
>
>   #: ref-filter.c:1311
>   #, c-format
> @@ -1249,14 +1249,14 @@ msgid "malformed object at '%s'"
>   msgstr "fehlerhaftes Objekt bei '%s'"
>
>   #: ref-filter.c:1373
> -#, fuzzy, c-format
> +#, c-format
>   msgid "ignoring ref with broken name %s"
> -msgstr "ignoriere Vorlage %s"
> +msgstr "Ignoriere Referenz mit fehlerhaftem Namen %s"
>
>   #: ref-filter.c:1378
> -#, fuzzy, c-format
> +#, c-format
>   msgid "ignoring broken ref %s"
> -msgstr "ignoriere Vorlage %s"
> +msgstr "Ignoriere fehlerhafte Referenz %s"
>
>   #: ref-filter.c:1651
>   #, c-format
> @@ -1680,17 +1680,17 @@ msgstr "Fehler beim Lesen von %s"
>
>   #: sha1_file.c:1080
>   msgid "offset before end of packfile (broken .idx?)"
> -msgstr ""
> +msgstr "Offset vor Ende der Packdatei (fehlerhafte Indexdatei?)"
>
>   #: sha1_file.c:2459
>   #, c-format
>   msgid "offset before start of pack index for %s (corrupt index?)"
> -msgstr ""
> +msgstr "Offset vor Beginn des Pack-Index f=C3=BCr %s (besch=C3=A4dig=
ter Index?)"
>
>   #: sha1_file.c:2463
>   #, c-format
>   msgid "offset beyond end of pack index for %s (truncated index?)"
> -msgstr ""
> +msgstr "Offset hinter Ende des Pack-Index f=C3=BCr %s (abgeschnitten=
er Index?)"
>
>   #: sha1_name.c:462
>   msgid ""
> @@ -1743,9 +1743,9 @@ msgid "staging updated .gitmodules failed"
>   msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vor=
merken"
>
>   #: trailer.c:237
> -#, fuzzy, c-format
> +#, c-format
>   msgid "running trailer command '%s' failed"
> -msgstr "Zusammenf=C3=BChren der \"Tree\"-Objekte %s und %s fehlgesch=
lagen"
> +msgstr "Ausf=C3=BChren des Anhang-Befehls '%s' fehlgeschlagen"
>
>   #: trailer.c:492 trailer.c:496 trailer.c:500 trailer.c:554 trailer.=
c:558
>   #: trailer.c:562
> @@ -4324,9 +4324,8 @@ msgid "HEAD is now at"
>   msgstr "HEAD ist jetzt bei"
>
>   #: builtin/checkout.c:665 builtin/clone.c:659
> -#, fuzzy
>   msgid "unable to update HEAD"
> -msgstr "Konnte HEAD nicht aufl=C3=B6sen."
> +msgstr "Konnte HEAD nicht aktualisieren."
>
>   #: builtin/checkout.c:669
>   #, c-format
> @@ -4864,6 +4863,8 @@ msgid ""
>   "No directory name could be guessed.\n"
>   "Please specify a directory on the command line"
>   msgstr ""
> +"Konnte keinen Verzeichnisnamen erraten.\n"
> +"Bitte geben Sie ein Verzeichnis auf der Befehlszeile an."
>
>   #: builtin/clone.c:305
>   #, c-format
> @@ -4945,9 +4946,9 @@ msgid "remote did not send all necessary object=
s"
>   msgstr "Remote-Repository hat nicht alle erforderlichen Objekte ges=
endet."
>
>   #: builtin/clone.c:647
> -#, fuzzy, c-format
> +#, c-format
>   msgid "unable to update %s"
> -msgstr "kann %s nicht =C3=B6ffnen"
> +msgstr "kann %s nicht aktualisieren"
>
>   #: builtin/clone.c:696
>   msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n=
"
> @@ -4960,9 +4961,8 @@ msgid "unable to checkout working tree"
>   msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
>
>   #: builtin/clone.c:753
> -#, fuzzy
>   msgid "unable to write parameters to config file"
> -msgstr "konnte Tag-Datei nicht schreiben"
> +msgstr "konnte Parameter nicht in Konfigurationsdatei schreiben"
>
>   #: builtin/clone.c:816
>   msgid "cannot repack to clean up"
> @@ -11674,7 +11674,7 @@ msgstr "Remote-Referenzen mitsamt den verbund=
enen Objekten aktualisieren"
>
>   #: common-cmds.h:32
>   msgid "Reapply commits on top of another base tip"
> -msgstr ""
> +msgstr "Wiederholtes Anwenden von Commits auf anderem Basis-Commit"
>
>   #: common-cmds.h:33
>   msgid "Reset current HEAD to the specified state"
>
