From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Mon, 4 Feb 2013 14:17:27 +0700
Message-ID: <CACsJy8C4MippsxZMdp0ZLmzQyJkAMe_2caFi3hbEDt4P+wNp6w@mail.gmail.com>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
 <1359870520-22644-1-git-send-email-pclouds@gmail.com> <vpqpq0hnlb1.fsf@grenoble-inp.fr>
 <CACsJy8CGqiahw3y42KRt61gChtfOucFHqZqn_uvLrj7j7KrQbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:18:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2GJp-0002lH-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 08:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab3BDHR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 02:17:59 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38122 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3BDHR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 02:17:58 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so5986016obc.27
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 23:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=T3/NcHs9BV+mz4VDtpRUMblXV5pT7tZkUHBEsCpZNRc=;
        b=PLkHyLTBy2bg+wMGg/ZH7hoThehNVk0LLwyPacK8Ar/y1IS+OG0Ymz42f8t4z7fTz1
         Ho0mpphVe/6G60SHoeibE9a4eciWYcg4JOPkSTKR81f6RpmLg2a4CST2G1JQGrZFyvus
         2Q2PxV+1xDKCj8T0GJi+WfQQ/pdPEC+enakOMdYTUTye42V0dgNKABgOq+8EP7bQwiw8
         f1Te3rgDRI+EZVWK704fVjDsKBiaRUgMJFCWNuWS+X1nytfQgTEm4AP5VByWA7ie74go
         pc6ibycgybVeNGvzYeqqVSTAyrV4LBTCrmLbBC6HILwiUjRgh1nM4fjeS75hLY2RfGOy
         1Oiw==
X-Received: by 10.60.8.131 with SMTP id r3mr15624137oea.14.1359962277906; Sun,
 03 Feb 2013 23:17:57 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Sun, 3 Feb 2013 23:17:27 -0800 (PST)
In-Reply-To: <CACsJy8CGqiahw3y42KRt61gChtfOucFHqZqn_uvLrj7j7KrQbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215363>

On Mon, Feb 4, 2013 at 2:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> * foo (rebasing)

Well, this one does not make sense (or causes more confusion).
-- 
Duy
