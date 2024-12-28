Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40068C8DF
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735392856; cv=none; b=jwKGzAGL1lQE8ECQKqHDogBS6jF05ss9UZhhjWyqKNbaa00t/eIKW5MDahcX5eySJ4ijz5KMdiq4PBSZd/eavhu0ESV8Eqijr8KYO6KWSLMC71t1/tWx7abBpWaeR+gEaisjK9ZCun3D41sMLtJbJokJq+R9nlCnYig0+Fc5rvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735392856; c=relaxed/simple;
	bh=70FCyU+OGbFh3b5hydSCZdHZRcANjH8OSlUgpOW/Jtk=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNwT3g4bdJ8c6DMYP5whw8OnafaBH+AFom6owlrsqBmGq9xK4VSUmgltHh6th04vSCPrFEe1HXyYTjZZ8OVqNr5LPaGGT/byOuyOodEJLjKivrgf0D2RbgGe8t3K2FiNLIkr6e9hPtE3hDd+CKQ23TWLjATMI0REnbPsLVxOtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BSDY3YC3895858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Dec 2024 13:34:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>, <git@vger.kernel.org>
References: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>
In-Reply-To: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>
Subject: RE: [fingerprint] of github.com
Date: Sat, 28 Dec 2024 08:33:58 -0500
Organization: Nexbridge Inc.
Message-ID: <025b01db592d$29cd4380$7d67ca80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIdltvCmuveCPUDdvsfyKvnmEADJLJ3LFQg
Content-Language: en-ca
X-Antivirus: Norton (VPS 241227-2, 12/27/2024), Outbound message
X-Antivirus-Status: Clean

On December 27, 2024 10:05 PM, A bughunter wrote:
>How would you confirm the correct SSH server fingerprint of github.com =
upon
>initial connection? Does GitHub post valid FP anywhere?

This is not the correct list for this question. Contact GitHub support, =
please.

