From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/8] git_remote_helpers: use 2to3 if building with
 Python 3
Date: Thu, 17 Jan 2013 21:15:08 -0800
Message-ID: <CAGdFq_gew1-YmeUh=brWREHSYQvaV7vRBmEo0KFzi-ViqzOnaw@mail.gmail.com>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
 <bcef80fb913ca829bd2d08284e364ebd55b7297e.1358448207.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 06:16:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw4JG-0007Hx-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 06:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab3ARFPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 00:15:49 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:51660 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab3ARFPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 00:15:49 -0500
Received: by mail-qa0-f45.google.com with SMTP id bv4so1068672qab.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 21:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QsZQvAoWf4OAi0YmLkiWinjC0gkHwLzl2ap1OmKfGEY=;
        b=aYQ/Rmg4uXD4iDMIoP1SV30j0PZ8aMiP3CC6o0qZSo2UOcH0RaYP5+3hFrSagOTUvL
         n8XT5HDnvAPjBDOV9X+tb8plFsSX4S+xdUaV8fCP0bd11iHISh3eHyk4j/HaRJ4gUmAv
         l3FIvbFmJlOrGLfTZIEfhQSI+e1HRMV73mGEPIcMvRDs9yKCLCG36JDYwzXGt5RfT/id
         c8Zgfv/n1Uv3B4dygBscUZ6fiwmhIKbqFIpJwLbXq7lkk4VHTrFRalo3vI4EpPZzdfGx
         QMpR+4iQAer/Zfl+gak3Vr9syg2rIrQ4FOGPacmYQhUgsujncqq9atKCHdRHNOImJug2
         A7uQ==
X-Received: by 10.229.198.217 with SMTP id ep25mr1825496qcb.59.1358486148562;
 Thu, 17 Jan 2013 21:15:48 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Thu, 17 Jan 2013 21:15:08 -0800 (PST)
In-Reply-To: <bcef80fb913ca829bd2d08284e364ebd55b7297e.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213903>

On Thu, Jan 17, 2013 at 10:53 AM, John Keeping <john@keeping.me.uk> wrote:
> [1] http://wiki.python.org/moin/PortingPythonToPy3k

This link seems dead.

--
Cheers,

Sverre Rabbelier
