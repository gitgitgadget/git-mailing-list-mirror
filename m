From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 11
Date: Thu, 15 Jul 2010 14:26:10 +0200
Message-ID: <20100715122610.GG22574@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 14:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZNUO-0002qu-OT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 14:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133Ab0GOMYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 08:24:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56792 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120Ab0GOMYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 08:24:24 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so137914eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=VcZKQAXws2y4Nde3wrSJvP8cABYUUhCPtNCOeUAI79A=;
        b=AoLc3EakMFaQ3FeDFiWQSG9kdB79Xjlr6osOJ9PTfLIDl231UMVJllEiGPKoEENzIp
         YhhRXax5cGyfnerIdgUh4i9Q4A8lekwOnoyJFMJOc9qGb1mxUy7BnekLyAh1VH1GSpEg
         sj1WcP0vz2dxwofD4GZjOhrWWnucGPPxzeWX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Hsi3Az3Os5pqL6L/K0QDL2yATbjDlrMj74GH5EWAtIYYdhXY3rGRRV+LRvTW8WmvUo
         U5Wg9HUSAaMc8yHoHX+bo9yUyzzebn4fFi0mOXRp5snP6HpwUyadkoI+Cl6iGHSH/FnC
         ZqELDZWpl8ahz2DLs2aqiuB0KkT5AdgJfGy3U=
Received: by 10.213.13.69 with SMTP id b5mr657304eba.69.1279196663339;
        Thu, 15 Jul 2010 05:24:23 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm7691087eeh.23.2010.07.15.05.24.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 05:24:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151078>

Hi,

The past few days have been a little unproductive in terms of code,
because I've been busy responding to email and finishing up some
administrative work. This is my last day in Copenhagen, and I'll be
travelling to India tomorrow; as a result of travelling and
administrative work back in India, I expect to be relatively
unavailable over the next few days. My timezone will change from: GMT
+0200 (CEST) to GMT +0530 (IST), but I expect to work late into the
night as usual back in India; so this change should make little
difference.

Thanks for reading.

-- Ram
