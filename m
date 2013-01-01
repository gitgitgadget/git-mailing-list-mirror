From: Dennis Heidsiek <dennis.heidsiek@gmail.com>
Subject: Re: [BUG] git fetch --all --tags doesn't fetch remote branches, only
 tags
Date: Tue, 01 Jan 2013 02:28:32 +0100
Message-ID: <50E23BC0.30504@gmail.com>
References: <50E2311D.8080707@gmail.com> <7vbod9d7qg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 02:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpqf8-0007hc-6J
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3AAB2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 20:28:38 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:65463 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3AAB2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 20:28:36 -0500
Received: by mail-bk0-f47.google.com with SMTP id j4so5562338bkw.20
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 17:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Lk2irsbAOeOvQFTBvvN8KjekGJBPCgYEveTvMoQ2WTs=;
        b=EpGbwqLn5o0W9l6g9tnCh6geuj5UXEll1vdVigiKaMvIDUyoD2bEzJOfXw03IM0S0L
         h9Ml3RB2EqW9CMu9ZyjQ/inkNvmKA882cgXTvJ8pHFrHl684cJHSGi70iyCyR11HvLP/
         CafcoTg3aF50r/lTPgOs8ItR8KG1wyYgfkxlQ9t+Wm8ozjCuho+7PLbNedyDWCb37GRg
         wOTWOYppJ9fv5dLa+1jBedQAqtuIZlmB0LVcB8uOdyQBnwp7cwKT9bfzcDBaHLrWuMEl
         sH2980H74zbuK9eyl+JM24vlTVwIjI1HqkTtiF45nYkJb0XHwA2uww2kTKpmUTuv/zmK
         M9mw==
X-Received: by 10.204.148.134 with SMTP id p6mr19620940bkv.75.1357003715360;
        Mon, 31 Dec 2012 17:28:35 -0800 (PST)
Received: from [192.168.178.20] (p57AEC653.dip0.t-ipconnect.de. [87.174.198.83])
        by mx.google.com with ESMTPS id o7sm28512550bkv.13.2012.12.31.17.28.32
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 17:28:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vbod9d7qg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212376>

Dear Mr. Hamano,


so i /did/ misunderstand the documentation =E2=80=93 my fault. Thank yo=
u very much for your rapid clarification!


With grateful greetings,
Dennis Heidsiek
