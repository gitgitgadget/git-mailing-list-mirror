From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 19:21:59 +0530
Message-ID: <CALkWK0k6qbTrqGgt_PVk=GN=bMaxVv9GDA=iHowRUbNjN+oLOg@mail.gmail.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
 <20130614131629.GA1086@paksenarrion.iveqy.com> <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
 <20130614135032.GA5394@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURR-0002gj-HB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab3FNNwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:52:41 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab3FNNwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 09:52:39 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so1482802iec.33
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=065S2phBSjIa8VsfN4It/9a6ffbpvhSciFcT9MgCK7A=;
        b=F4D4c670XUBAYphJtA9vGfSTuZ1Ma2a12oXHWHrZcInmsydvwNT4UMeeFaDpJ0600e
         1FuzlMgxgcKXHrV+w3ITXwpZ5RqFMX9ydaTtggcshXMciIOaTFIf6DtaSLrVOEdZaM9/
         p2NMJafZOmkeWjDyJpi81I+wha/hFn/hi8DBQniCHEIiCHQg5Gyg6i0v6vm5CX9hziTY
         qtTgLAg4EoWBqnoh+wtx/Q+fqY43H81DMpFWdUNSiUEZimPD7iYKlNPERoQ26G4Z3vvT
         qiI2CVicZUST2+KKR+QCwN4F0XPnJfUtG83qGV/Rf5oercsYgkC0Y/MEgZmTNxVNMwA9
         QOaA==
X-Received: by 10.50.23.8 with SMTP id i8mr1106726igf.42.1371217959397; Fri,
 14 Jun 2013 06:52:39 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 06:51:59 -0700 (PDT)
In-Reply-To: <20130614135032.GA5394@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227867>

SZEDER G=C3=A1bor wrote:
>   _git_fp () { _git_format_patch ; }

Good stopgap, thanks.
