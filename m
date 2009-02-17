From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 01/10] config: Codestyle cleanups.
Date: Tue, 17 Feb 2009 17:33:01 +0100
Message-ID: <bd6139dc0902170833r7e6672f4p831dacb2ed841b32@mail.gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:34:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZSuE-0007Bm-Mh
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbZBQQdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZBQQdG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:33:06 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:3442 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbZBQQdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:33:03 -0500
Received: by fg-out-1718.google.com with SMTP id 16so466982fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=WAFsno6NS6HOsluMH0nhgTXNpsPGA+7Y2mAHbH1tcFI=;
        b=w7iOe05sVNgauBKQ/cnQmTHKBUZCYR0XM6AMR20XnMTF3wq2WmtVLdqu4cxnmbJk7f
         +X3GPatVzX2RVKWxQfgBzC57hQCy0Jm6yzEvMdjFSVZ3Y52dgHRlAfNVrZiYOZfXXad8
         zcjOLv9T2HIeKzI5kwCgieoO9UF6rXgQ6wf4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wejrpHaC82HDBQxh0goBK7VUueT1juBFboDg22cmiNm19XFVU5RUzmAPNrijqXqbNS
         WNbaM3WPeIgKvyaB6fpd9oVs6lVnQXXc8YjK4S+xJiG5zid7OO61MqV5UcRrKNHR6fbg
         LH62OcK47iNnBazBJ7OsMeAq5UBS3Tcy4czLw=
Received: by 10.86.33.10 with SMTP id g10mr2163310fgg.44.1234888381806; Tue, 
	17 Feb 2009 08:33:01 -0800 (PST)
In-Reply-To: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: bc10734cd3bfbee1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110408>

On Tue, Feb 17, 2009 at 14:52, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Did I miss 0/10 somehow? If not, it would be nice to have one if you
send a long patch series :). That way I can ignore v3 of the series if
the cover letter tells me nothing significant (to me) has changed. 1
minutes to write for you, saves 5 minutes for all reviewers :).

-- 
Cheers,

Sverre Rabbelier
