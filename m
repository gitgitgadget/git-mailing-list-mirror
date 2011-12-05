From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Roadmap for 1.7.9
Date: Mon, 5 Dec 2011 22:24:33 +0100
Message-ID: <CACBZZX6aC-E4DxaZzzhfGnK8ovBGCq_gNG3hPU7QjfAiNb3WrA@mail.gmail.com>
References: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 22:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXg22-000748-Ns
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 22:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab1LEVY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 16:24:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37758 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1LEVYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 16:24:55 -0500
Received: by eeaq14 with SMTP id q14so2327062eea.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bx/2EyGrGEH5wQIh3kuBIPvcDDfe8r69VDc+lhV2M2I=;
        b=Irn19FzOe00R7KtnUFn5+ZfRwRqo4mKWSUK3REZKmO1nN0Z222GL9OBRrBLap4tzoD
         H33zgWyvui2yYa5VxBFqCWxZNyVrSQ1EHS1je0/wiz/5LWWHlFcc9FAgArYA76mLoaRr
         MfkEWv20U3Sy2Eu2l42HGVh06TP1Kqj0gQYmY=
Received: by 10.14.15.16 with SMTP id e16mr1412849eee.72.1323120294256; Mon,
 05 Dec 2011 13:24:54 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Mon, 5 Dec 2011 13:24:33 -0800 (PST)
In-Reply-To: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186290>

On Mon, Dec 5, 2011 at 21:07, Junio C Hamano <gitster@pobox.com> wrote:

> Now, here are the biggies that we would want to try to have in reasonable
> shape before the next release.

I'd like to get the i18n series into 1.7.9 as well. I think it's ready
as-is but some minor issues are sure to arise.

If time permits I'd also like to have a series of po/*.po files in as
well once it's in "master". Maybe as a submodule, which would be neat
in itself as we'd start dogfooding submodules.
