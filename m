From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-gui: update Japanese translation
Date: Thu, 27 Nov 2008 07:10:03 +0900
Message-ID: <20081127071003.6117@nanako3.lavabit.com>
References: <7vskpedumw.fsf@gitster.siamese.dyndns.org>
 <20081126192144.6117@nanako3.lavabit.com> <20081126212828.GA20382@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 23:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Sbt-0001at-2J
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 23:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYKZWKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYKZWKc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 17:10:32 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46216 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbYKZWKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 17:10:31 -0500
Received: from a.earth.lavabit.com (a.earth.lavabit.com [192.168.111.10])
	by karen.lavabit.com (Postfix) with ESMTP id CB4DCC7AF1;
	Wed, 26 Nov 2008 16:10:30 -0600 (CST)
Received: from 1291.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id MD5QO2ILLTAJ; Wed, 26 Nov 2008 16:10:30 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vZGsH3/F+j6XbIq7gkX8N+rEFz3MwdZdDEhgvkOCxeBgGAOyFE5gb2f84Swo+oDXHEsWwxnmrxG5fSwW4+RUBK76HGHUWODjxI2ZpBr872K/YBI9MedUxIhfz0QXJ4uTqgIwFSuOBHWUkD+iLlNOx1MORXLarRnAVjFT26PhS/Q=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vskpedumw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101778>

Quoting Junio C Hamano <gitster@pobox.com>:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> $ make V=1
>> msgfmt --statistics --tcl -l ja -d po/ po/ja.po
>> po/ja.po:1558: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:1567: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:1602: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:1883: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:1931: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:1941: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:2342: `msgid' and `msgstr' entries do not both begin with '\n'
>> po/ja.po:2455: `msgid' and `msgstr' entries do not both begin with '\n'
>> msgfmt: found 8 fatal errors
>> make: *** [po/ja.msg] Error 1
>
> Feel free to squash this in; I just removed the extra "\n" at the
> beginning of these messages.

Thank you for catching and fixing my mistakes.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
