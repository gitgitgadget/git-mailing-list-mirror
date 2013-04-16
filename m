From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Tue, 16 Apr 2013 13:07:29 +0530
Message-ID: <CALkWK0=FozUTS5EFMXdhU50M1WjgGD9DsAVF8AcqPVLMaPz_HA@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr> <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr> <20130416005836.GC14995@sigill.intra.peff.net>
 <7vwqs3nm88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US0T1-0004bm-AR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3DPHiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 03:38:10 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:52198 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3DPHiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 03:38:09 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so149729iae.14
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GY3Fvq1C53EwDGo8mIFuG9+GNsSKpnwAS4qyid5peVY=;
        b=e7PbQwk6G+1rF3cAVD0mTGcZ+v/AERGajqa6+Vz56ZAnHmTbjhGKigSXFZbnN5MooO
         eJ54/dUs6alXj1ZkETGLxllUQcOCRm9hSJh2uily1npN28O4hUQbovdfaoENY6OcNJmo
         j6+87QDNfg8udZkHeK/Oy69l0+xklwc8tU1/VWMc03Ngw+SSc7/hWOo4bDpo8lEy3fPS
         2Lq70QLrH1DWG3R5heMVoPRoNBoZcFp3mCN2h5n//rkz0Ix8QLCmXXiQlHjOuZS5CGB4
         ZyQ+StUEbPAN249yToaHSwI6BsEnO3tqeWJ5p7kamXtKuigbk1IcCKMEtnny3srVp7uT
         xBYw==
X-Received: by 10.50.50.71 with SMTP id a7mr7078726igo.14.1366097889226; Tue,
 16 Apr 2013 00:38:09 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 00:37:29 -0700 (PDT)
In-Reply-To: <7vwqs3nm88.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221375>

Junio C Hamano wrote:
> I'd hate to see any Git developers running with advice turned off
> for this exact reason.

Improving advice is your itch, but it is certainly not my itch.  I
don't want to see messages like "Commit your changes or stash them",
or "try --continue | --skip | --abort" cluttering up my valuable
terminal output when I know what to do.  I don't care how they can be
made "better", because I don't want to see them in the first place.

You should have nothing against me for running with all advice turned
off.  It's not your job to dictate how a software should be used, but
rather design it so that intended usage is the most intuitive.
