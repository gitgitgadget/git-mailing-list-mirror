From: Maria Jose Fernandez <mjose.fernandezj@gmail.com>
Subject: problems installing GIT on my MAC OS X 10.11.5
Date: Tue, 14 Jun 2016 16:56:15 +0100
Message-ID: <1F59C8B7-AF53-4C84-9428-5A4AB80DB295@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 17:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCqhU-0002vZ-9S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 17:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcFNP4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 11:56:19 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35233 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcFNP4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 11:56:19 -0400
Received: by mail-wm0-f50.google.com with SMTP id v199so127643819wmv.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=UPrkYWv+zNLQHnAy+52G8dQR9enyK9AHxXOcg3TApLo=;
        b=oxe8OGLS6OB5ieqTfONRFNXlKBqzMUa7n5PRAWM7vittTw69DngcnalSVjnCyWC7St
         cVziyc3NXvZINTN4plE6VUAnlIzuqPGst2HMCzam6SFwEEMfn/23ZKPlTxHdhcTfpt6P
         l8WW6rmqb32fe2vCCAuGLtM416mPW2qOCVEKyGiovHRgiQg07iqwMQQjYWT/Ih/lTOKF
         QNNNQnLnOmjxoiuZyGKYokWKsJNxhFviBvMBCu0pOVB9Y39gXD82TDwaT/T3T93XYEtU
         0f13nTR3NzXCvSWDq8Wsh9Ng019Cl8VOqvdTSnAVDH9UfHbg68r/PQIx62m+C+/1MdKO
         s/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=UPrkYWv+zNLQHnAy+52G8dQR9enyK9AHxXOcg3TApLo=;
        b=kuUYe7EkHDv4kKQmAfFy7XkVf/PVsc7D3hRMDpFQRl+oNmqMHOLRfwR/tIUs3ArLPw
         8+K3l16kBu/rWjHYjH2dZeR5W4iPbwmq4cUWvy1V5S+oYneJ/fpNzHnMNn531chQIRGg
         QwcDciY1TNgwqfwU7t3Cz44OqwkxaPGgZLTvK3RfNOcpUaPLBs/dlbe/VRmhyvZN+bQT
         P+wJabTDTsscrn9J6OPJnSHbqmXZWSQTPQ2DfAmTXGeSW0cM2EHvby4+twJNWXGYuMOV
         ywjIm5hafAHxKWjzIbrTR2cILGqnn69JT+xRCIBMXlB/fptVVHBUtv3Tj+ByxioczQGQ
         blxw==
X-Gm-Message-State: ALyK8tI+HqqxMBMRPSCQ9c3Ksv9SXHeU0pogD3pVc3T8x+FTZf3HK4n2kxbn+MTJKyqaWg==
X-Received: by 10.194.21.39 with SMTP id s7mr7111844wje.24.1465919777415;
        Tue, 14 Jun 2016 08:56:17 -0700 (PDT)
Received: from [192.168.0.8] (cpc75192-slam8-2-0-cust379.2-4.cable.virginm.net. [82.28.141.124])
        by smtp.gmail.com with ESMTPSA id db6sm33590462wjb.2.2016.06.14.08.56.16
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jun 2016 08:56:16 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297300>

Hello,=20
I am doing a data science course and need to download GIT but for some =
reason I can=E2=80=99t installed it. I called Apple but they couldn=E2=80=
=99t help and suggested me to contact you guys.=20

I hope you can help me.
Thank you very much,

Maria Jose Freeman