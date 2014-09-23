From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH 3/7] part3: l10n: de.po: use imperative form for command
 options
Date: Tue, 23 Sep 2014 12:24:13 +0200
Message-ID: <54214A4D.8080904@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com> <1411146770-8508-4-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 12:24:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWNGn-000749-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 12:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbaIWKYS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2014 06:24:18 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:59995 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbaIWKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 06:24:15 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so937321wgg.31
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KqeQXqwSkmgzhKc1qhL4JCdRbKoqSP4TMabNkmzFbGM=;
        b=kfhXOO71mxMBh1f2hQABMSAW5QY8z9PpU845WZzm4ADsBpocA8oHj15IxyxsfbXK9G
         u3K0vfGQIsDd4iVcNYWFFyrDmH/+vmnvbRxrfPX7S4qx9WrarsLoqNdIt9AvqFCehEsh
         QklCDpjifY0uyIFVh4pvABB+h/d0ChI0iMZVSfKQR5fGu3stmpHvjplLM53sTSFC+vZZ
         MJxsUfZ/nuASPWr2uP7ckRISkN7VlFTHQSZdaNHntrurx2hA/kvehi3VsjPb6G7owdNP
         BzTKvn/JhYHhRsJEubUpezI5QpBWsShaK0dRKKfeMeFY+v7R5F1ZIMPNsyLTVyMYq3AV
         uKuA==
X-Received: by 10.194.95.234 with SMTP id dn10mr27527006wjb.73.1411467854519;
        Tue, 23 Sep 2014 03:24:14 -0700 (PDT)
Received: from [192.168.178.43] (i577AA68D.versanet.de. [87.122.166.141])
        by mx.google.com with ESMTPSA id v9sm15387702wjy.14.2014.09.23.03.24.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2014 03:24:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1411146770-8508-4-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257409>

Hi,

>  #: builtin/describe.c:395
>  msgid "find the tag that comes after the commit"
> -msgstr "findet das Tag, das nach Commit kommt"
> +msgstr "das Tag finden, das nach Commit kommt"
> =20

"das Tag finden, das nach dem Commit kommt"

>  #: builtin/fast-export.c:718
>  msgid "Use the done feature to terminate the stream"
> -msgstr "Benutzt die \"done\"-Funktion um den Strom abzuschlie=C3=9Fe=
n"
> +msgstr "die \"done\"-Funktion benutzen um den Strom abzuschlie=C3=9F=
en"
> =20

"die \"done\"-Funktion benutzen, um den Strom abzuschlie=C3=9Fen"

Maybe its better to use =C2=BBStream=C2=BB instead of =C2=BBStrom=C2=AB=
 in general?

Phillip
