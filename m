From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: log: option "--follow" not the default for a single file?
Date: Tue, 29 Nov 2011 19:25:47 +0100
Message-ID: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 19:25:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSNN-0007kX-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 19:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab1K2SZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 13:25:48 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47321 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab1K2SZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 13:25:48 -0500
Received: by yenl6 with SMTP id l6so4355358yen.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PZqH6avWPZF9x8gF1CaXFF+YLYsl/cEIltayjBeGRu4=;
        b=avTJH/Vl7HcygopqNCq/PX7jWojWi+zqqkCjW9mnL8c7+qzJKAySv2ZbE+ynYUnezE
         1l1x/Arzti3KBzxpsoPgs7CLV6BQlRqpknh+tUzxRzqNlLO4DdCBVaFMmlcahsCn4KuB
         VgIdCU0Twg0Ds+2m+2Fjd9GWgdfj3gH2m6M1o=
Received: by 10.100.190.15 with SMTP id n15mr2505318anf.50.1322591147783; Tue,
 29 Nov 2011 10:25:47 -0800 (PST)
Received: by 10.146.249.18 with HTTP; Tue, 29 Nov 2011 10:25:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186071>

Why is the option "--follow" not the default if the log-command
is used with a single file? Many GUI tools don't show me the
full history of a single file if there was a rename in it.

Thanks
