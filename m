From: Adam Mercer <ramercer@gmail.com>
Subject: Re: post-receive-email hook with custom_showrev
Date: Mon, 25 Feb 2013 19:39:44 -0600
Message-ID: <CA+mfgz3j7sbqOHOZkBm+dH08+QmyerGeVLLPnF2LeYn=y_Qs1Q@mail.gmail.com>
References: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 02:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA9dm-0001Fc-9y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 02:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab3BZBrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 20:47:09 -0500
Received: from mail-qe0-f46.google.com ([209.85.128.46]:33402 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab3BZBrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 20:47:07 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 20:47:07 EST
Received: by mail-qe0-f46.google.com with SMTP id a11so809061qen.33
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=4+ISXvORz5IKMikZzyeQTrwL+aMv7fWPB6zzEiWfUgg=;
        b=R09x0cfxCKO8y3JkgeJwJLO/2TBmJdo86CgZ3ahpOjhVBK3W7yhGkoXxrHvI4Mo8+7
         5BZFoK2aETI+0oxin4z6ult9V4J3vz3/mvSW6MqwDS/kGMoBp4TuMoEjkDmnrobGWwSV
         d74jbq1s1HaiGc71pub5cf/Wm+xJK1zOOahr2FuUMygYICrzVnHaY9JmbRcrthY6k1BW
         RKmv3MH2k7bU6JT2DUzytG6dVcVYQGCg/r/IKFAILrtbxBBVn/sJLP7Yzgjy7HJzq4Ny
         H5ACNnoi+FLRre/R1HnfqPZ0KPoS5zJ3wNV4Sevi8oq437i0HD/7DpCbBkl18q06QNLW
         B7AA==
X-Received: by 10.224.106.201 with SMTP id y9mr14641474qao.3.1361842824952;
 Mon, 25 Feb 2013 17:40:24 -0800 (PST)
Received: by 10.49.63.136 with HTTP; Mon, 25 Feb 2013 17:39:44 -0800 (PST)
In-Reply-To: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217124>

On Fri, Feb 22, 2013 at 2:57 PM, Adam Mercer <ramercer@gmail.com> wrote:

> So it seems as if showrev is being ignored? Can anyone see what I'm doing wrong?

Anyone? From looking at the documentation I can't see anything wrong
but as it's not displaying anything something is clearly wrong.

Cheers

Adam
