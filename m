From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: I still haven't had time for the i18n series, help welcome
Date: Wed, 20 Jul 2011 23:49:16 +0200
Message-ID: <CACBZZX4zJk21sd9i8T-B_Jv2TqVCuT71nJoGuGjPPU3Ovwn9RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jan Engelhardt <jengelh@medozas
X-From: git-owner@vger.kernel.org Wed Jul 20 23:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjedw-0002bA-Df
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 23:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab1GTVtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 17:49:19 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:58012 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1GTVtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 17:49:18 -0400
Received: by fxd18 with SMTP id 18so2314687fxd.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9rO+WKZaThruLDg7IBn9Kh2f8/uAShXGw00Qkeq4imk=;
        b=RG4b3JhtPxZWuqxn3yAzZ+hZ5gcdi4prFbOuU/+I177L0g+bScBTJp6AYtrQPLuh0v
         PDD76mUEqW/naXkXYGaQAHWw9cTYtzvG7y/mSoPZU7mSwMQxCFYzp59/Z9c0SVrv/FUu
         0aAfRWAl0KuPdk5MV8rGpihi9UHuQ8ryq3fWE=
Received: by 10.223.21.141 with SMTP id j13mr603271fab.79.1311198556993; Wed,
 20 Jul 2011 14:49:16 -0700 (PDT)
Received: by 10.223.60.204 with HTTP; Wed, 20 Jul 2011 14:49:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177550>

Due to work and personal reasons I still haven't had time to get the
rest of the i18n series in shape, and probably won't anytime soon.

It's still sitting in the ab/i18n branch at
git://github.com/avar/git.git if anyone's interested in submitting
something from it.

In particular it would be very useful if the German translation at
"git://dev.medozas.de/git i18n" and the Hindi Ramkumar submitted could
make it in.

The stuff in ab/i18n mostly works. But what I haven't had time to do
is to re-do it in smaller more digestable chunks.
