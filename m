From: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
Subject: How to import bzr repository into git
Date: Tue, 16 Nov 2010 20:57:45 +0100
Message-ID: <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 20:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIRf7-0002aW-Gs
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab0KPT5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:57:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55644 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758466Ab0KPT5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:57:48 -0500
Received: by wyb28 with SMTP id 28so1097500wyb.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=iiuQPrkvWNClZ2EhIGc6eMkbIZWpMo0Y8YtitK+Iszg=;
        b=PVACK7BcWWHALwEahD9exiDWXv50hzOujeO/cNOEpUPBY1z9YNGm71BMBWy/1MDZ81
         TD74NhXFKHB5i6xatlu0lE/v+6XLjDpsiYzSiH4lpHZMrdYI8e7S77piSeWYFKfwXHfK
         /LOT+nMWyz4p+BFCXTA5DdqzEbvRvtAerlEuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=bm3uZ/9CEwiUnSi2CGK86RO/PxsbxTkM3yx5MEWIYSXrXgJoT1hDor25BbA5myMUJF
         g0yB1iF7E7LoDSKuo6p6eh2lv04QU7ucQ6Uvyacj9RgE6cFFgX+dVHfKxWf1kxiOAw9l
         P/L2mrfHFRoBrXO7fyAsMhqZnzNa28/AJs8SY=
Received: by 10.227.134.149 with SMTP id j21mr8122328wbt.194.1289937465785;
 Tue, 16 Nov 2010 11:57:45 -0800 (PST)
Received: by 10.227.27.131 with HTTP; Tue, 16 Nov 2010 11:57:45 -0800 (PST)
In-Reply-To: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161582>

Hello!

I want to migrate one of my projects from Bazaar to git, preserving the history.

How can I do that in Windows (import an existing Bazaar project into a
new/empty git repository) ?

Thanks in advance

Dmitri
