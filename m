From: Phillip Susi <psusi@ubuntu.com>
Subject: gitk won't show notes?
Date: Thu, 02 Apr 2015 15:34:17 -0400
Message-ID: <551D99B9.7040200@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydktg-0004g5-GU
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbDBTfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:35:20 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33083 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbDBTfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:35:18 -0400
Received: by qgdy78 with SMTP id y78so16487701qgd.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=3JGb6PwVVwh2xM8SOCR70+7maZANAIBA/kCt1PNvais=;
        b=IJ8h3GvPdbrZoIyjRGzZl2cicsjYVlCBxNWllsfn8QYpKTncWutZF88Z3JEaCMsyjI
         sHM6fZ9C4Wq26XM+Jl4O5vvW8YFfnxmVBFR7h95FE+797lFJg/6eRa1XhCa5iGZWIVDu
         o40X784p6sK15JdNG4bpuKk7okAWcJGdt8iirgKEyVUEAUYmM7BE18dfMRKs9fo4kBFI
         3TlZvP1u5/Cmf/Gbrou8KLqa+iDR7qG9yBDHykVJQLBxH4aVYfunKAZyBo5yeazxEcYI
         SYT5slBwSBtZHkrWQOW7dLevhyPcVghGXp0yfGtpsuea6Gtdhp5hJLPbss6M+ypuuGrl
         VAXQ==
X-Received: by 10.140.33.46 with SMTP id i43mr61652827qgi.21.1428003318220;
        Thu, 02 Apr 2015 12:35:18 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id 102sm4124718qkt.2.2015.04.02.12.35.17
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 12:35:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266662>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can't seem to get gitk to show notes, even when I give it --notes.
Does it just not handle notes?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVHZm5AAoJENRVrw2cjl5RT0wIAJVfE2cDQODUCoOsIwhVDiMf
CNeTKy1VxCgwVy8KDoYxY2hBlDIRELkcVIkN5ueNVu57LZ+1z/iBUhgr3mmzH9br
z2viRjkKRlNSqP/b+HwK0+GxBIbN/FpIEyKTPe558SMcUjCkeINfxfcgYYbmY4Rv
aY60j4LMQCEgltkmyDJ/kRX1I7Pr4YCfwNfoIQj3LxvCY5WL7VGn7QmM56Qh9m8P
DVvTdMHBnhLOTCSa79/uAAZKJxVNE7z8YnHw1aimNXs/uwm7DYl4coxXVGDxyUfm
DnEDcqtLfFst58UtLDRn7f3YawT7heeeXJ7tKUAizX3YQuTTRp9WrN12yE7Crxo=
=Z23X
-----END PGP SIGNATURE-----
