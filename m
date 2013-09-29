From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 00/44] Ruby support
Date: Sun, 29 Sep 2013 09:43:54 +0530
Message-ID: <CALkWK0nfP5CZYSvqrYeBAqkjCE_Zg-QenRcNZcP3-K7qPrZhoQ@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8PB-000606-ES
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab3I2EOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:14:36 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43154 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3I2EOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:14:35 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so7408218iec.16
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NpZ4OBFDpmqu0+5FAR8rcKtxJUkVX/P1njCg7hwRbg8=;
        b=nfq4jQo/qaLxPOn0GxRuafbZUyb9raZWAJy+hljh3Or7f8M/W3aGscJvciVhHfXi1o
         /bEEQY70i+PDkWBFAkqzGN233VO6UKEwCiIPPJ2Gzz3SIT2Tvneqa5fOV7cySVzV743r
         I22uPpK9fsZyw24TYeyCe7weR+OklriMOjZesHgO3/T6O7MuOpLmcbMShZaEz9MoXQop
         myfqz5nlcd6O4ukxxVKa3o6c6L8D8P1kKtWeW+yHH4LiCXwKFqUKEgR3Rj9QC3QH/qcm
         s1HJdBAHaYC77ge31roXGyKMxB68LoVDo731THfnzc5rxBpI188PPIhDiObZybgprcuj
         8KVg==
X-Received: by 10.50.23.16 with SMTP id i16mr8640234igf.50.1380428074489; Sat,
 28 Sep 2013 21:14:34 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 21:13:54 -0700 (PDT)
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235577>

Felipe Contreras wrote:
> Felipe Contreras (44):

Thanks! In the meantime, can you publish this work somewhere so we can
easily try it out?
