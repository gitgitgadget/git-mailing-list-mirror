Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D54E1B5
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556529; cv=none; b=GUzsZ+pjoGYPlOIdi9Gphflhhze/RIpc/4jA7XRCJer2guq4A239hvGYKUe1lAjKJAs5U1ktQPTxT1wJLdFv4lvv7HOSlM3rvYjnpeA2Ag3kUUHHXNoIJZ1cBcLsWyOM6m31PwpfmWiM4I8ZQwe4/WvEfJWFet4Tx96qvaPanMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556529; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=D34TFaOePhcA10FF+B/l3MHBTa8+A+LesvK9Nuguawt/ojOen6EVdYyTU2RB9wx35rpCfoBkBBv09TdHT2AFMbdKf9sGnDAzoJG0MElnWwazDAN8wVQ28opO9hOLEYixURqvmG8KQzmkU0DVWvHM+jhtynoWQl+bkxYwRThIqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cGZB3tCG; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cGZB3tCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1706556528;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=cGZB3tCG8UCaX/RBeLa5RgUwNcx/1MnyJRrLSPT4AfGA8sf1Jce+M8XMtAfh1NBgb
	 dWbXVFwx6OIoxgbGZY1OiwdNpeJ0KG+JFiSuC+cRuZCtBcpmyFRBxTpoMnZIiIW+6C
	 Ozu+OV88qNEqaYdvcT91BdXL2j7bBiD+eqi/XnlbsFKF69yAbw9SlpTyhSmjyWg1Dc
	 Lm5bnIjNjkge5q7rZX04mIvygzsPqgkeowy58nHTNdFC/agvt2nB9UUydp3K1ARAJ4
	 9/OJgdAUGUvcqVUAUy+tbhk7pMLbN1VkaMjiL9gQ0Xa6OJrzHzLRtOztfYq0EAUo6P
	 4aTHyWeyR1Rfw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id AF8A62633486
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 19:28:46 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: G G <fayazgujjar555@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 30 Jan 2024 00:28:41 +0500
Subject: Y
Message-Id: <52DF893F-8DFF-4BC9-9DD3-CB4321C59935@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21C66)
X-Proofpoint-ORIG-GUID: uiCbvSb36Kj-Ru4PDKQ6SZlWzPZnoe-l
X-Proofpoint-GUID: uiCbvSb36Kj-Ru4PDKQ6SZlWzPZnoe-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=472 bulkscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401290145


Sent from my iPhone
