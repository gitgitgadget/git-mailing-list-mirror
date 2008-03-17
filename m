From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [announce] text-based tree visualizer
Date: Mon, 17 Mar 2008 21:40:43 +0800
Message-ID: <46dff0320803170640g52411015g7bbe315df2b0bb56@mail.gmail.com>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Mar 17 14:41:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbFah-0007sB-KW
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 14:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbYCQNkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbYCQNkr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 09:40:47 -0400
Received: from hs-out-0708.google.com ([64.233.178.247]:1448 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYCQNkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 09:40:46 -0400
Received: by hs-out-0708.google.com with SMTP id 4so4088930hsl.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=649POLAT3MUbepgwl/2MtSON5ANfRcv/ImUeLqHoSSk=;
        b=ImQciznEIyq51B3RwGT09JK9ftiDL3atHShHJhUeK9BKl12SSu/IU7vqcUnsX1j1IyMffVZ4BROF+UB2AvnzdODcOnr5uUI6TmIRY3A+F1b8C4Y+HKKJ8LTUEyUdzjZZoazd0b4D06i1rDwOWvjmObXc0gsZxxERpPmBhG5PCwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DanH2FK3gT8FsvZFNl/+NEx71jkAH1EtYW6sUe3tjp+Dsv4O+//THnSlVz4yxE+43arFEGMsQOdDBzLz/8BgbZT50N3ckmIEmekT7mbFCzLhGzN5svZ8Sa8fNqOiwuxf4baNAgHqVx2P8vJK5jyYN/KDED+9A6tXhqAiAiGM0c0=
Received: by 10.100.144.18 with SMTP id r18mr32583747and.112.1205761246140;
        Mon, 17 Mar 2008 06:40:46 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 17 Mar 2008 06:40:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77430>

T24gRnJpLCBNYXIgNywgMjAwOCBhdCAxOjQ4IEFNLCBKYW4gRW5nZWxoYXJkdCA8amVuZ2VsaEBj
b21wdXRlcmdtYmguZGU+IHdyb3RlOgo+IEhlbGxvIGV2ZXJ5b25lLAo+Cj4KPiAgSSBzcGVudCB0
aGUgbGFzdCB0d28gZGF5cyB3cml0aW5nIGEgdGV4dC1iYXNlZCB0cmVlIHZpc3VhbGl6ZXI7Cj4g
IGdpdGsgaXMgcmVhbGx5IGNvbnZlbmllbnQsIGJ1dCB1bmZvcnR1bmF0ZWx5IGl0IG5lZWRzIGFu
IFggZGlzcGxheSwKPiAgdGlncyB0cmVlIHZpZXcgbGVmdCBtZSB1bmltcHJlc3NlZCwgYW5kIEkg
YWN0dWFsbHkgd2FudGVkIGEgdG9vbAo+ICB0aGF0IGRvZXMgbm90IHJlYWQgYWxsIGNvbW1pdHMg
aW4gbGlrZSBnaXRrL3RpZyBkbywgYnV0IGp1c3QgZ2l2ZXMgbWUKPiAgdGhlIHRyZWV2aWV3Lgo+
CkhlcmUgaXMgbXkgdmlldwrilZEg4pWRIOKVkSDilZ8gTWVyZ2UgYnJhbmNoICdqay9wb3J0YWJs
ZScK4pWRIOKVkSDilZEg4pWg4pWQ4pWXCuKVkSDilZEg4pWRIOKVnyDilZEgTWVyZ2UgYnJhbmNo
ICdweS9zdWJtb2R1bGUnCuKVkSDilZEg4pWRIOKVoOKVkOKVrOKVkOKVlwrilZEg4pWRIOKVkSDi
lZ8g4pWRIOKVkSBNZXJnZSBicmFuY2ggJ2RiL2RpZmYtdG8tZnAnCuKVkSDilZEg4pWRIOKVoOKV
kOKVrOKVkOKVrOKVkOKVlwrilZEg4pWRIOKVkSDilZ8g4pWRIOKVkSDilZEgTWVyZ2UgYnJhbmNo
ICdjYy9oZWxwJwrilZEg4pWRIOKVkSDilaDilZDilazilZDilazilZDilazilZDilZcK4pWRIOKV
kSDilZEg4pWfIOKVkSDilZEg4pWRIOKVkSBzaG9ydGxvZzogZG8gbm90IHJlcXVpcmUgdG8K4pWR
IOKVkSDilZEg4pWfIOKVkSDilZEg4pWRIOKVkSBNZXJnZSBicmFuY2ggJ21haW50JwrilZEg4pWR
IOKVkSDilaDilZDilazilZDilazilZDilazilZDilazilZDilZcKCkl0IHNlZW1zIG1lc3NlZCB1
cC4KCgoKLS0gClBpbmcgWWluCg==
