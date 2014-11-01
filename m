From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Startup of Git 2.2.0 l10n round 1
Date: Sat, 1 Nov 2014 08:13:19 +0800
Message-ID: <CANYiYbH-Gz8rSo1OX8ApA1ysgpi=YaE+yq9XDOa-DUXeppxQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Brian Gesiak <modocache@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>,
	Harring Figueiredo <harringf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkMJp-00060Y-7G
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 01:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbaKAANV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2014 20:13:21 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:51935 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaKAANU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2014 20:13:20 -0400
Received: by mail-wg0-f50.google.com with SMTP id z12so7474075wgg.23
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e894EWdGEiYg/DqdnE5CZ59KaO8v3UdW2PKIvdWi5fk=;
        b=jlQtXI44jcyaQxC2e9DkC9Xhq2Ypwf0l/8nitETE0TFCy63Ksj5+L2QMfoxTH9srdX
         FQ5dAxCeQ2zA+n6Wm1qPuU9e3LBtYmdFYprGgpPUyx1wXvA1Jb/riHbdBLC4UAd+k5bO
         9cydsz76ytY9UmTlf5Py+byv4z/Q/BvNWONPReUqxOAkkiOGPKIyOoNLq+abVkcWavJe
         9/GjPjy2mzmTDHHP/BeG1wXvc5e8SrWl7q+f+STX9I6qVOLsZXyyUzdSfiNaRxzT2y9K
         5MuxLR3Hau8sQAFjQXk3ZQYlwaq9xdhpJOKvZowNE5Vffiit8T6GRwsZ4SnVu9nJGudi
         u4Zg==
X-Received: by 10.180.39.106 with SMTP id o10mr560854wik.54.1414800799488;
 Fri, 31 Oct 2014 17:13:19 -0700 (PDT)
Received: by 10.194.250.104 with HTTP; Fri, 31 Oct 2014 17:13:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Since Git v2.2.0-rc0 had already been released, it's time to start new =
round
of git l10n. This time there are 62 new messages need to be translated =
since
last update for v2.1.0:

    l10n: git.pot: v2.2.0 round 1 (62 new, 23 removed)

    Generate po/git.pot from v2.2.0-rc0 for git v2.2.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
