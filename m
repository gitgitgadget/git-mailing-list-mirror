From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: I can never finish a push
Date: Mon, 26 Dec 2011 20:18:14 -0800
Message-ID: <1324959494.1755.9.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: mresnick@bbn.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 05:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfOV1-0002Fu-IB
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 05:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab1L0ESb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 23:18:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59012 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab1L0ESa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 23:18:30 -0500
Received: by iaeh11 with SMTP id h11so19780340iae.19
        for <git@vger.kernel.org>; Mon, 26 Dec 2011 20:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=4qxxUvMVnhw0xJ28nR0zhcOk8sQQdP8fmQwUpIdUi0A=;
        b=CAl1aEyrtmaYHh2F2HDu1oTZ1tsyLSSpQgJthdqpi6DdULMWzenXAHaC2CW9t+ucd8
         TyVHG/mGQr9gBpf8gCVOmj/etOhxvnKefOILfnf6psrGrsYat0ARMR+RfTggvsMWh4NN
         +2MnJfv4gQ20LlJswrg6xyQiWjC6L/Sgs8/pw=
Received: by 10.50.153.234 with SMTP id vj10mr28980438igb.16.1324959509791;
        Mon, 26 Dec 2011 20:18:29 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id aq5sm63959078igc.5.2011.12.26.20.18.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Dec 2011 20:18:28 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187706>

Aside from the other comments, you said, "someone else on-site
pushes and adds new commits before mine can finish."  If I
interpreted that correctly, the "someone else" should also be
using a link as slow as yours.  Why isn't he having the same
problem you are having?

If you can track that person down (his name should show up in
the new commits you pulled), compare your config files to see
what is different.

Bill
