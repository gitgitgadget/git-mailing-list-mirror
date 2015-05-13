From: chenxitwo <chenxitwo@126.com>
Subject: Git: How to keep multiple bare repos in sync?
Date: Wed, 13 May 2015 12:09:10 +0800
Message-ID: <2015051312090840845945@126.com>
Reply-To: chenxitwo <chenxitwo@126.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 13 06:09:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsNyw-00010i-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbbEMEJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:09:14 -0400
Received: from m15-114.126.com ([220.181.15.114]:41637 "EHLO m15-114.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbbEMEJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=SuPuE
	jYut6piLjuG4OBr1it+zLir+IgXVeXKpvWFXWQ=; b=SgaKY8uGI58lNI9m/v7bC
	B4gP1eVXazLmyjNTJ1lrOtrc2MRo8K+XkwFIlAwvdPcqlzdkjhHva6s6TLzyJ5un
	TkHTIzivgsp9cVn0mHkNkfOjKuKSxHSQ1ugXfn+xPsAh55vKlKMZqem+WSV73YH6
	BIWcjVH04aveKGnwq1+XO0=
Received: from eg080 (unknown [113.91.49.135])
	by smtp7 (Coremail) with SMTP id DsmowAC33w9kzlJVATx7AA--.37389S2;
	Wed, 13 May 2015 12:09:10 +0800 (CST)
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.0.1.92[cn]
X-CM-TRANSID: DsmowAC33w9kzlJVATx7AA--.37389S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4zB-DUUUU
X-Originating-IP: [113.91.49.135]
X-CM-SenderInfo: hfkh05plwz0qqrswhudrp/1tbiWwb451PM8aJtywAAso
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268922>

VGhlcmUgYXJlIHRocmVlIGdpdCBzZXJ2ZXIoYmFyZSByZXBvcyksIGJ1dCBpIGRvbid0IGtub3cg
dG8gc29sdmUgdGhlIHByb2JsZW0gdGhhdCBob3cgdG8ga2VlcCB0aGVzZSBnaXQgc2VydmVycyBp
biBzeW5jLg0KDQoNCg0KDQoNCg0KY2hlbnhpdHdv
