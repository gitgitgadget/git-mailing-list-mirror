From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: How is git used as other than the project's version control?
Date: Tue, 28 Apr 2009 00:06:24 +0100
Message-ID: <18071eea0904271606t4757a01di40e7b0cf6c558bea@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZuE-0003uC-53
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbZD0XG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 19:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbZD0XGZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:06:25 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:51002 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbZD0XGZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:06:25 -0400
Received: by ewy24 with SMTP id 24so234971ewy.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RGAVniO5iRJsGBQDWXKYQHa6cSYrJksyRz5hCHaNKF8=;
        b=lnidm1c2zuqEYqZsuz9d98t1gSCQ1ZWk7QPEU6sqM34ra5dseSx8DLjgwWEpVyfenY
         OnqFXo4X4+uofPHAxW/n5CL+e/gblbWkYfgSdCV8YmAZM38uhg5MUHyywfVSY31Y6EjG
         b9ZSO9glF8EZ9E2oBWd6qSDVXHmr10QFXgSMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mV+vrsnUzav4NxcZOe1oiHNYHp/CDSo+56MPEZ66TnGjno7iTR/vrVnsfJeQnnNWza
         /wBQ9h5VkI3Gpd2bgcKUPcArID1W2OfUTDvQL2dLfVU7aZWxfeS9FlbMA3u7cUY0Yj+I
         OzYpj4Xef6jRUbNENEAR9ZZWTHaGvI9xFksAM=
Received: by 10.210.10.11 with SMTP id 11mr1673998ebj.11.1240873584052; Mon, 
	27 Apr 2009 16:06:24 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117727>

2009/4/27 John Dlugosz <JDlugosz@tradestation.com>:
> But what about using it as a tool, wielded separately from applying
> those tools to a git repository infrastructure? =A0For example, use i=
t to
> separate out hunks and untangle mixed work. =A0You could do this even=
 if
> your directory has nothing to do with git normally.

What is it you're really asking here?  I use "git diff" all the time
outside of $GIT_DIR for instance -- invaluable, and was designed
deliberately that way.

-- Thomas Adam
