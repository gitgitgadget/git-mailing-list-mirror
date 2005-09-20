From: Stefhen Hovland <stefhen.hovland@gmail.com>
Subject: [PATCH][COGITO] Add .deb build support to Makefile
Date: Mon, 19 Sep 2005 19:23:56 -0500
Message-ID: <7c278d0c05091917232c79b909@mail.gmail.com>
Reply-To: stefhen.hovland@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_950_30897807.1127175836619"
X-From: git-owner@vger.kernel.org Tue Sep 20 02:24:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVvU-0007YK-65
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVITAX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVITAX5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:23:57 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:10769 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbVITAX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:23:57 -0400
Received: by xproxy.gmail.com with SMTP id i27so230867wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 17:23:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=evB2mSoMU7GGJcs829Vr8wjLGetVK8sALwbDp3DJOMu94amRoY1xb+5x+G9Y2CroWeL0a5f5/bv4bH/Ksy93iTRQV6AKExv0iCXK5Q+rEONNXTtudHWd4Xzthq9BIDL3kpfkTflg26gIUBpMo+H2zhL6BNn98QQgcCFNogfnvmE=
Received: by 10.70.37.9 with SMTP id k9mr1662813wxk;
        Mon, 19 Sep 2005 17:23:56 -0700 (PDT)
Received: by 10.70.12.11 with HTTP; Mon, 19 Sep 2005 17:23:56 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8933>

------=_Part_950_30897807.1127175836619
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Attached is a simple patch adding support to cogito for "make deb".
Please use if useful or let me know if this patch is offbase..

Thanks,
Stefhen

------=_Part_950_30897807.1127175836619
Content-Type: text/plain; name="2005-09-19.Makefile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2005-09-19.Makefile.diff"

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFr
ZWZpbGUKQEAgLTEyNSw2ICsxMjUsMTIgQEAgZGlzdDogY29naXRvLnNwZWMKIHJwbTogZGlzdAog
CXJwbWJ1aWxkIC10YSAkKEdJVF9UQVJOQU1FKS50YXIuZ3oKIAorZGViOiBkaXN0CisJcm0gLXJm
ICQoR0lUX1RBUk5BTUUpCisJdGFyIHp4ZiAkKEdJVF9UQVJOQU1FKS50YXIuZ3oKKwlkcGtnLXNv
dXJjZSAtYiAkKEdJVF9UQVJOQU1FKQorCWNkICQoR0lUX1RBUk5BTUUpICYmIGZha2Vyb290IGRl
Ymlhbi9ydWxlcyBiaW5hcnkKKwogUG9ydGZpbGU6IFBvcnRmaWxlLmluICQoVkVSU0lPTikgZGlz
dAogCXNlZCAtZSAncy9AQFZFUlNJT05AQC8kKHNoZWxsIGNhdCAkKFZFUlNJT04pIHwgY3V0IC1k
Ii0iIC1mMikvZycgPCBQb3J0ZmlsZS5pbiA+IFBvcnRmaWxlCiAJZWNobyAiY2hlY2tzdW1zIG1k
NSAiIGBtZDVzdW0gJChHSVRfVEFSTkFNRSkudGFyLmd6IHwgY3V0IC1kICcgJyAtZiAxYCA+PiBQ
b3J0ZmlsZQo=
------=_Part_950_30897807.1127175836619--
