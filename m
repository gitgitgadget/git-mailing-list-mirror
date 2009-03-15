From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: excluding files from a merge
Date: Mon, 16 Mar 2009 07:14:40 +0900
Message-ID: <20090316071440.6117@nanako3.lavabit.com>
References: <loom.20090315T011519-497@post.gmane.org>
 <76718490903150547o1c791d35r5d71000b481f443b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Jacobs <djacobs7@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 23:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liyds-00004r-Tb
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 23:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbZCOWPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 18:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbZCOWPj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 18:15:39 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41666 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbZCOWPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 18:15:38 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 9FB7211B7F1;
	Sun, 15 Mar 2009 17:15:36 -0500 (CDT)
Received: from 9494.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id YIR0VBPOS29N; Sun, 15 Mar 2009 17:15:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=uiKhYRDmzvFd3BHfpiSFM3nSEN0QcyVw2/AggmdHqbbwxWaezqB+9rHQP7KiiHvUrZ+zVJ4ZynqEoZMoKi2gMg50KlDQajR+F0+/aZquEt7rIql8PL7yvzT8AX7trYRu+mLe8Lg6hFu7JMbFtOa06heAlcmWU0+38oVJZ8D3WNg=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <76718490903150547o1c791d35r5d71000b481f443b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113301>

Quoting Jay Soffian <jaysoffian@gmail.com>:

> On Sat, Mar 14, 2009 at 9:23 PM, Daniel Jacobs <djacobs7@gmail.com> w=
rote:
>> I would like it if every file was merged, except for files that were=
 explictly
>> excluded from a merge between these two branches. =C2=A0Is there a g=
ood way to do
>> this?
>
> Please see http://thread.gmane.org/gmane.comp.version-control.git/110=
488
> (Is there a way to exclude user-specified files or directories from
> participating in merges?)
>
> I believe it is the same use case, and Junio provided a very detailed=
 reply.

Would it help to have the final summary by Sitaram Chamarty

    http://article.gmane.org/gmane.comp.version-control.git/110697

somewhere under Documentation/howto?


--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
